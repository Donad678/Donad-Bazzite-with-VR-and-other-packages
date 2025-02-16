# build envision
dnf5 install -y meson rustc gtk4-devel gtk4-devel cargo openssl-devel libadwaita-devel vte-2.91-gtk4
git clone https://gitlab.com/gabmus/envision/
cd envision
meson setup build -Dprefix="/usr" -Dprofile=development
ninja -C build
ninja -C build install
# cp -r -v ./build/localprefix/* /usr/
cd ../
rm -r -f ./envision