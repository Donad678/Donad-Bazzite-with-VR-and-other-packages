#! /bin/bash
# install envision
set -ouex pipefail
#dnf5 install -y envision-monado envision-wivrn
dnf5 install -y wivrn-dashboard
#dnf5 -y remove envision
dnf5 -y install envision-nightly --allowerasing

# Removed packages: bluez-libs

dnf5 install -y glslc libusb1 onnx-libs onnxruntime opencv SDL3 libbsd x264-libs vulkan-loader openxr
dnf5 install -y 'opencv*' --exclude='*devel*' --exclude='*doc*' --exclude='*examples*' --exclude='*java*' --allowerasing

dnf5 install -y openvr-api openxr-libs libwayland-client
dnf5 install -y libdav1d

# wayvr deps
dnf5 install -y fontconfig freetype libxkbcommon libxkbcommon-x11 alsa-lib pipewire libshaderc openxr openvr-api libX11 libXext libXrandr
cd /usr/lib64
L=$(ls libopenvr_api.so.[0-9]*.[0-9]*.[0-9]* | sort -V | tail -n1)   # libopenvr_api.so.2.0.0
V=${L#*so.}                                                          # 2.0.0
ln -sf "$L" "libopenvr_api.so.${V%%.*}"                              # .so.2 -> .so.2.0.0
ln -sf "libopenvr_api.so.${V%%.*}" libopenvr_api.so                  # .so   -> .so.2
ldconfig
# Install Monado binary for envision to make new installations easier
#dnf5 -y copr enable joviatrix/monado-git
#dnf5 -y install monado
#dnf5 -y copr disable joviatrix/monado-git
dnf5 -y install xr-hardware

# cp /tmp/misc/other/openvrpaths.vrpath /usr/lib/xrizer/openvrpaths.vrpath
