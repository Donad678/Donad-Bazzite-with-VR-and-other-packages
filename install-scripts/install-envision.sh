#! /bin/bash
# install envision
set -ouex pipefail
#dnf5 install -y envision-monado envision-wivrn
dnf5 install -y wivrn-dashboard
#dnf5 -y remove envision
dnf5 -y install envision-nightly --allowerasing

dnf5 install -y glslc libusb1 onnx-libs onnxruntime opencv SDL3 libbsd x264-libs bluez-libs vulkan-loader openxr
dnf5 install -y 'opencv*' --exclude='*devel*' --exclude='*doc*' --exclude='*examples*' --exclude='*java*' --allowerasing

dnf5 install -y openvr-api openxr-libs libwayland-client

# wayvr deps
dnf5 install -y fontconfig freetype libxkbcommon libxkbcommon-x11 alsa-lib pipewire libshaderc openxr openvr libX11 libXext libXrandr
# Install Monado binary for envision to make new installations easier
#dnf5 -y copr enable joviatrix/monado-git
#dnf5 -y install monado
#dnf5 -y copr disable joviatrix/monado-git
dnf5 -y install xr-hardware

# cp /tmp/misc/other/openvrpaths.vrpath /usr/lib/xrizer/openvrpaths.vrpath
