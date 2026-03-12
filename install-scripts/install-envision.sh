#! /bin/bash
# install envision
set -ouex pipefail
#dnf5 install -y envision-monado envision-wivrn
dnf5 install -y wivrn-dashboard
#dnf5 -y remove envision
dnf5 -y install envision-nightly --allowerasing

dnf5 install -y glslc libusb1 onnx-libs onnxruntime
# Install Monado binary for envision to make new installations easier
#dnf5 -y copr enable joviatrix/monado-git
#dnf5 -y install monado
#dnf5 -y copr disable joviatrix/monado-git
dnf5 -y install xr-hardware

# Set nice for monado
/usr/bin/setcap CAP_SYS_NICE=eip /usr/bin/monado-service

# Edit Envision .desktop to force restart headset on start
desktop-file-edit --set-key="Exec" --set-value="/usr/bin/forceRestartIndex envision" "/usr/share/applications/org.gabmus.envision.Devel.desktop"

# fix index on boot
install -m 644 -o root -g root "/tmp/misc/udev/60-valve-index-reboot.rules" "/etc/udev/rules.d/60-valve-index-reboot.rules"

# cp /tmp/misc/other/openvrpaths.vrpath /usr/lib/xrizer/openvrpaths.vrpath
