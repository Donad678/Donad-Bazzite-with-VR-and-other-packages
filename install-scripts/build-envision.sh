# build envision
set -ouex pipefail

# desktop dependencys
dnf5 --setopt=disable_excludes=* install -y SDL3-devel sdl2-compat-devel



dnf5 install -y --setopt=tsflags=noscripts cmake eigen3-devel gcc-c++ git-lfs glslang-devel glslc libbsd-devel mesa-libGL-devel systemd-devel libX11-devel libxcb-devel libXrandr-devel ninja-build opencv-devel openxr-devel vulkan-devel vulkan-loader-devel wayland-devel wayland-protocols-devel
dnf5 install -y meson x264-devel rustc gtk4-devel gtk4-devel cargo openssl-devel libadwaita-devel vte-2.91-gtk4 clang-devel libusb1 libusb1-devel onnx-devel onnx-libs onnxruntime onnxruntime-devel
dnf5 install -y mesa-libgbm-devel libglvnd-devel

#dnf5 install -y envision-monado envision-wivrn
dnf5 install -y wivrn-dashboard
#dnf5 -y remove envision
dnf5 -y install envision-nightly --allowerasing

# Install Monado binary for envision to make new installations easier
dnf5 -y copr enable joviatrix/monado-git
dnf5 -y install monado
dnf5 -y copr disable joviatrix/monado-git
dnf5 -y install xr-hardware

# Set nice for monado
/usr/bin/setcap CAP_SYS_NICE=eip /usr/bin/monado-service

# Edit Envision .desktop to force restart headset on start
#desktop-file-edit --set-key="Exec" --set-value="/usr/bin/forceRestartIndex envision" "/usr/share/applications/org.gabmus.envision.Devel.desktop"

# fix index on boot
curl -fsSL https://raw.githubusercontent.com/MiguVT/fixvr/main/src/install.sh | bash

#Old build process removed
#git clone https://gitlab.com/gabmus/envision/
#cd envision
#meson setup build -Dprefix="/usr" -Dprofile=development
#ninja -C build
##ninja -C build install
# cp -r -v ./build/localprefix/* /usr/
#cd ../
#rm -r -f ./envision
