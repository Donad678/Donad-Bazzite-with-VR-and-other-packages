# build envision
# desktop dependencys
dnf5 install -y meson rustc gtk4-devel gtk4-devel cargo openssl-devel libadwaita-devel vte-2.91-gtk4
#wivrn deps
dnf5 install avahi-devel avahi-glib-devel cli11-devel gstreamer1-plugins-base-devel gstreamer1-devel ffmpeg-devel ffmpeg-devel ffmpeg-devel libnotify-devel pipewire-devel ffmpeg-devel libva-devel json-devel x264-devel
git clone https://gitlab.com/gabmus/envision/
cd envision
meson setup build -Dprefix="/usr" -Dprofile=development
ninja -C build
ninja -C build install
# cp -r -v ./build/localprefix/* /usr/
cd ../
rm -r -f ./envision
