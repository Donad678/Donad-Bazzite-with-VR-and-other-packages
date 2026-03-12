# This must be at the very top, before FROM
ARG BASE_IMAGE=fakeImage
ARG IS_KDE=false

# Build applications without polluting final image
#FROM ${BASE_IMAGE} AS builder

#COPY / /tmp/
#RUN dnf5 config-manager setopt terra.enabled=1 terra-extras.enabled=1 terra-mesa.enabled=1 fedora-multimedia.enabled=1 && \
#    dnf5 -y copr enable bazzite-org/bazzite-multilib
#RUN /tmp/install-scripts/build-envision.sh

# Build final image

FROM ${BASE_IMAGE}

ARG IS_KDE

## Other possible base images include:
# FROM ghcr.io/ublue-os/bazzite:stable
# FROM ghcr.io/ublue-os/bluefin-nvidia:stable
# 
# ... and so on, here are more base images
# Universal Blue Images: https://github.com/orgs/ublue-os/packages
# Fedora base image: quay.io/fedora/fedora-bootc:41
# CentOS base images: quay.io/centos-bootc/centos-bootc:stream10

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

COPY install-scripts/ /tmp/install-scripts/
COPY misc/ /tmp/misc/
COPY *.sh /tmp/
#COPY --from=builder /tmp/staging/ /tmp/from-builder/

RUN mkdir -p /var/lib/alternatives

RUN cp -rnv /tmp/from-builder/usr/* /usr/ && \
    rm -rf /tmp/from-builder

RUN dnf5 config-manager setopt terra.enabled=1 terra-extras.enabled=1 terra-mesa.enabled=1 fedora-multimedia.enabled=1 && \
    dnf5 -y copr enable bazzite-org/bazzite-multilib && \
    dnf5 -y copr enable derisis13/ani-cli && \
    dnf5 -y copr enable faugus/faugus-launcher

RUN dnf5 install -y \
    dotnet-sdk-10.0 \
    dotnet-sdk-9.0 \
    wine wine-mono wine-devel \
    ntfs2btrfs \
    krusader

RUN dnf5 install -y \
    ani-cli \
    faugus-launcher

RUN /tmp/install-scripts/install-virtualhere-server.sh
RUN /tmp/install-scripts/build-envision.sh
RUN /tmp/install-scripts/install-envision.sh
RUN /tmp/install-scripts/lsfg-vk.sh
RUN /tmp/install-scripts/install-custom-scripts.sh

RUN if [ "${IS_KDE}" == "true" ]; then \
        echo "KDE detected, running KDE additions..."; \
        /tmp/build_kde_additionals.sh; \
    else \
        echo "Non-KDE image, skipping KDE additions."; \
    fi

RUN dnf5 config-manager setopt terra.enabled=0 terra-extras.enabled=0 terra-mesa.enabled=0 fedora-multimedia.enabled=0 && \
    dnf5 -y copr disable bazzite-org/bazzite-multilib && \
    systemctl disable podman.socket

# --- LAYER: Cleanup ---
# We delete /tmp and clear dnf cache to save space
RUN rm -rf /tmp/* && \
    dnf5 clean all

RUN ostree container commit
