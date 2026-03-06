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
desktop-file-edit --set-key="Exec" --set-value="/usr/bin/forceRestartIndex envision" "/usr/share/applications/org.gabmus.envision.Devel.desktop"

# fix index on boot
install -m 644 -o root -g root "/tmp/misc/udev/60-valve-index-reboot.rules" "/etc/udev/rules.d/60-valve-index-reboot.rules"

# install xrizer
mkdir -p /tmp/xrizer-extract
curl -Lo /tmp/xrizer.zip https://nightly.link/Supreeeme/xrizer/workflows/ci/main/xrizer-nightly-release.zip
unzip /tmp/xrizer.zip -d /tmp/xrizer-extract
mkdir -p /usr/lib/xrizer
cp -rv /tmp/xrizer-extract/xrizer/bin /usr/lib/xrizer/
ls -R /usr/lib/xrizer
chmod -R 755 /usr/lib/xrizer
chown -R root:root /usr/lib/xrizer
rm -rf /tmp/xrizer-extract /tmp/xrizer.zip

# install wayvr by unpacking appimage
mkdir -p /tmp/wayvr
cd /tmp/wayvr/
mv /tmp/misc/appimages/wayvr.appimage ./
#curl -Lo wayvr.zip https://nightly.link/wlx-team/wayvr/workflows/build-appimage/main/WayVR-main-x86_64.AppImage.zip
#unzip wayvr.zip
#mv WayVR-x86_64.AppImage wayvr.appimage
chmod +x wayvr.appimage
./wayvr.appimage --appimage-extract
cp -rfnv ./squashfs-root/usr /
cd /tmp
rm -r -f /tmp/wayvr

#Old build process removed
#git clone https://gitlab.com/gabmus/envision/
#cd envision
#meson setup build -Dprefix="/usr" -Dprofile=development
#ninja -C build
##ninja -C build install
# cp -r -v ./build/localprefix/* /usr/
#cd ../
#rm -r -f ./envision
