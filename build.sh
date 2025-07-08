#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# dnf5 update -y

# Add terra repo
# Bazzite disabled this for some reason so lets re-enable it again
dnf5 config-manager setopt terra.enabled=1 terra-extras.enabled=1 terra-mesa.enabled=1 fedora-multimedia.enabled=1
dnf5 -y copr enable bazzite-org/bazzite-multilib
# install krusader
dnf5 install -y krusader

# install lact
#dnf5 install -y lact

# install dotnet 8/9
dnf5 install -y dotnet-sdk-8.0 dotnet-sdk-9.0

# Because I can, here is ani-cli, an anime watch tool for linux
dnf5 -y copr enable derisis13/ani-cli
dnf5 -y install ani-cli
dnf5 -y copr disable derisis13/ani-cli


# Install BS-Manager for easier Beat Saber modding
# /tmp/install-scripts/install-bsmanager.sh

# Install Virtual Here USB Server
/tmp/install-scripts/install-virtualhere-server.sh

# build envision
/tmp/install-scripts/build-envision.sh

# install windows 95
# /tmp/install-scripts/install-windows95.sh

# install telescope
dnf5 -y install telescope

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

dnf5 config-manager setopt terra.enabled=0 terra-extras.enabled=0 terra-mesa.enabled=0 fedora-multimedia.enabled=0
dnf5 -y copr disable bazzite-org/bazzite-multilib

systemctl enable podman.socket
