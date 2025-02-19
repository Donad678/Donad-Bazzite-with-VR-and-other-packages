#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# install krusader
dnf5 install -y krusader
# Build dependencys for Envision
dnf5 install -y cmake eigen3-devel gcc-c++ git-lfs glslang-devel glslc libbsd-devel mesa-libGL-devel systemd-devel libX11-devel libxcb-devel libXrandr-devel mesa-libGL-devel ninja-build opencv-devel openxr-devel SDL2-devel vulkan-devel vulkan-loader-devel wayland-devel wayland-protocols-devel
# install lact
dnf5 install -y lact
# install dotnet 8/9
dnf5 install -y dotnet-sdk-8.0 dotnet-sdk-9.0

# build envision
/tmp/install-scripts/build-envision.sh

# install windows 95
/tmp/install-scripts/install-windows95.sh



# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
