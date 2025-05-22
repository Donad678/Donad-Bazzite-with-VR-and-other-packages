# build envision
set -ouex pipefail

# desktop dependencys
dnf5 --setopt=disable_excludes=* install -y SDL3-devel sdl2-compat-devel
dnf5 install -y cmake eigen3-devel gcc-c++ git-lfs glslang-devel glslc libbsd-devel mesa-libGL-devel systemd-devel libX11-devel libxcb-devel libXrandr-devel ninja-build opencv-devel openxr-devel vulkan-devel vulkan-loader-devel wayland-devel wayland-protocols-devel
dnf5 install -y meson rustc gtk4-devel gtk4-devel cargo openssl-devel libadwaita-devel vte-2.91-gtk4 clang-devel libusb1 libusb1-devel onnx-devel onnx-libs onnxruntime onnxruntime-devel
#dnf5 install -y boost-devel avahi-devel bluez-libs-devel dbus-devel gstreamer1-devel gstreamer1-plugins-base-devel hidapi-devel ffmpeg-devel cjson-devel libdrm-devel libjpeg-turbo-devel pipewire-devel libusb1-devel libuvc-devel libva-devel json-devel openhmd-devel openvr-devel librealsense-devel egl-wayland-devel x264-devel cli11-devel avahi-glib-devel libnotify-devel
#dnf5 install -y envision-monado
git clone https://gitlab.com/gabmus/envision/
cd envision
meson setup build -Dprefix="/usr" -Dprofile=development
ninja -C build
ninja -C build install
# cp -r -v ./build/localprefix/* /usr/
cd ../
rm -r -f ./envision
