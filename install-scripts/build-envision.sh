# build envision
set -ouex pipefail

# desktop dependencys
dnf5 --setopt=disable_excludes=* install -y SDL3-devel sdl2-compat-devel



dnf5 install -y --setopt=tsflags=noscripts cmake eigen3-devel gcc-c++ git-lfs glslang-devel glslc libbsd-devel mesa-libGL-devel systemd-devel libX11-devel libxcb-devel libXrandr-devel ninja-build opencv-devel openxr-devel vulkan-devel vulkan-loader-devel wayland-devel wayland-protocols-devel
dnf5 install -y meson x264-devel rustc gtk4-devel gtk4-devel cargo openssl-devel libadwaita-devel vte-2.91-gtk4 clang-devel libusb1 libusb1-devel onnx-devel onnx-libs onnxruntime onnxruntime-devel
dnf5 install -y mesa-libgbm-devel libglvnd-devel

# install wayvr by unpacking appimage
mkdir -p /tmp/wayvr
cd /tmp/wayvr/
#mv /tmp/misc/appimages/wayvr.appimage ./
curl -Lo wayvr.zip https://nightly.link/wlx-team/wayvr/workflows/build-appimage/main/WayVR-main-x86_64.AppImage.zip
unzip wayvr.zip
mv WayVR-x86_64.AppImage wayvr.appimage
chmod +x wayvr.appimage
./wayvr.appimage --appimage-extract
cp -rfnv ./squashfs-root/usr /
cd /tmp
rm -r -f /tmp/wayvr

#dnf5 install -y envision-monado envision-wivrn
dnf5 install -y wivrn-dashboard
#dnf5 -y remove envision
dnf5 -y install envision-nightly --allowerasing

# Install Monado binary for envision to make new installations easier
#dnf5 -y copr enable joviatrix/monado-git
#dnf5 -y install monado
#dnf5 -y copr disable joviatrix/monado-git
dnf5 -y install xr-hardware

#Compile monado ourselves
mkdir -p /tmp/monado-build
cd /tmp/monado-build
git clone https://gitlab.freedesktop.org/monado/monado.git
cd /tmp/monado-build/monado
mkdir /tmp/monado-build/monado/build
cd /tmp/monado-build/monado/build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug -G "Unix Makefiles"
cmake --build .
cmake --build . --target install

# Set nice for monado
/usr/bin/setcap CAP_SYS_NICE=eip /usr/bin/monado-service

# Edit Envision .desktop to force restart headset on start
desktop-file-edit --set-key="Exec" --set-value="/usr/bin/forceRestartIndex envision" "/usr/share/applications/org.gabmus.envision.Devel.desktop"

# fix index on boot
install -m 644 -o root -g root "/tmp/misc/udev/60-valve-index-reboot.rules" "/etc/udev/rules.d/60-valve-index-reboot.rules"

# install xrizer
mkdir -p /tmp/xrizer-build
cd /tmp/xrizer-build
git clone https://github.com/Supreeeme/xrizer.git
cd /tmp/xrizer-build/xrizer
mkdir -p /tmp/cargo_home
export CARGO_HOME=/tmp/cargo_home
cargo xbuild --release
mkdir -p /usr/lib/xrizer/bin/linux64
mv /tmp/xrizer-build/xrizer/target/release/libxrizer.so /usr/lib/xrizer/bin/linux64/vrclient.so
mv /tmp/xrizer-build/xrizer/target/release/bin/version.txt /usr/lib/xrizer/bin/version.txt
mv /tmp/misc/other/openvrpaths.vrpath /usr/lib/xrizer/openvrpaths.vrpath
cd /tmp
rm -r -f /tmp/xrizer-build
rm -r -f /tmp/cargo_home
#Old build process removed
#git clone https://gitlab.com/gabmus/envision/
#cd envision
#meson setup build -Dprefix="/usr" -Dprofile=development
#ninja -C build
##ninja -C build install
# cp -r -v ./build/localprefix/* /usr/
#cd ../
#rm -r -f ./envision
