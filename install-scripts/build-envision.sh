# build envision
set -ouex pipefail

# desktop dependencys
dnf5 --setopt=disable_excludes=* install -y SDL3-devel sdl2-compat-devel
#dnf5 install -y cmake eigen3-devel gcc-c++ git-lfs glslang-devel glslc libbsd-devel mesa-libGL-devel systemd-devel libX11-devel libxcb-devel libXrandr-devel ninja-build opencv-devel openxr-devel vulkan-devel vulkan-loader-devel wayland-devel wayland-protocols-devel
dnf5 install -y meson rustc gtk4-devel gtk4-devel cargo openssl-devel libadwaita-devel vte-2.91-gtk4 clang-devel libusb1 libusb1-devel onnx-devel onnx-libs onnxruntime onnxruntime-devel

dnf5 -y copr enable bazzite-org/bazzite-multilib
dnf5 -y install x264-devel clang-devel git-lfs
dnf5 install -y envision-monado envision-wivrn
#dnf5 -y remove envision
dnf5 -y copr disable bazzite-org/bazzite-multilib
dnf5 -y install envision-nightly --allowerasing
#git clone https://gitlab.com/gabmus/envision/
#cd envision
#meson setup build -Dprefix="/usr" -Dprofile=development
#ninja -C build
##ninja -C build install
# cp -r -v ./build/localprefix/* /usr/
#cd ../
#rm -r -f ./envision
