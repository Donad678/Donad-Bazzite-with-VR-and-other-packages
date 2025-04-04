# build envision
set -ouex pipefail

# desktop dependencys
dnf5 update -y
dnf5 install -y cmake eigen3-devel gcc-c++ git-lfs glslang-devel glslc libbsd-devel mesa-libGL-devel systemd-devel libX11-devel libxcb-devel libXrandr-devel ninja-build opencv-devel openxr-devel SDL2-devel vulkan-devel vulkan-loader-devel wayland-devel wayland-protocols-devel
dnf5 install -y meson rustc gtk4-devel gtk4-devel cargo openssl-devel libadwaita-devel vte-2.91-gtk4 clang-devel
#dnf5 install -y envision-monado envision-wivrn
git clone https://gitlab.com/gabmus/envision/
cd envision
meson setup build -Dprefix="/usr" -Dprofile=development
ninja -C build
ninja -C build install
# cp -r -v ./build/localprefix/* /usr/
cd ../
rm -r -f ./envision
