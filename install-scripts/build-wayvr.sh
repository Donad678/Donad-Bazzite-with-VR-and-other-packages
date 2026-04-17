# build wayvr based on the pkgbuild from https://aur.archlinux.org/packages/wayvr-git
set -ouex pipefail

dnf5 install -y xz ca-certificates
dnf5 --setopt=disable_excludes=* install -y pipewire-devel --best --allowerasing
dnf5 install -y cmake libxkbcommon libxkbcommon-devel libxkbcommon-x11-devel fontconfig fontconfig-devel dbus dbus-devel alsa-lib alsa-lib-devel libshaderc-devel openssl-devel python3 wayland-devel pkgconf-pkg-config

STAGING_DIR="/tmp/staging"

export ORT_ROOT="/tmp/ort_runtime"
mkdir -p "$ORT_ROOT"
export ORT_STRATEGY="download"
export XDG_CACHE_HOME="/tmp/wayvr-build/cache"
mkdir -p "$XDG_CACHE_HOME"
export ORT_DEBUG=1

mkdir -p /tmp/wayvr-build
cd /tmp/wayvr-build
git clone https://github.com/wlx-team/wayvr.git repo

mkdir -p /tmp/cargo_home
export CARGO_HOME=/tmp/cargo_home

export CARGO_PROFILE_RELEASE_DEBUG=2
export CMAKE_POLICY_VERSION_MINIMUM=3.5
export SHADERC_LIB_DIR=/usr/lib64
RUST_TARGET=$(rustc -vV | sed -n 's/host: //p')

cd /tmp/wayvr-build/repo/wayvr
cargo fetch --locked --target "$RUST_TARGET"
cargo build --frozen --release --all-features

cd /tmp/wayvr-build/repo/wayvrctl
cargo fetch --locked --target "$RUST_TARGET"
cargo build --frozen --release --all-features

mkdir -p $STAGING_DIR/usr/bin
mkdir -p $STAGING_DIR/usr/share/applications
mkdir -p $STAGING_DIR/usr/share/icons/hicolor/128x128/apps
mkdir -p $STAGING_DIR/usr/share/icons/hicolor/scalable/apps

cd /tmp/wayvr-build/repo
mv target/release/wayvr $STAGING_DIR/usr/bin/wayvr
mv target/release/wayvrctl $STAGING_DIR/usr/bin/wayvrctl

cd /tmp/wayvr-build/repo/wayvr
mv wayvr.desktop $STAGING_DIR/usr/share/applications/wayvr.desktop
mv wayvr.png $STAGING_DIR/usr/share/icons/hicolor/128x128/apps/wayvr.png
mv wayvr.svg $STAGING_DIR/usr/share/icons/hicolor/scalable/apps/wayvr.svg

cd /tmp
rm -r -f /tmp/wayvr-build
rm -r -f /tmp/cargo_home
