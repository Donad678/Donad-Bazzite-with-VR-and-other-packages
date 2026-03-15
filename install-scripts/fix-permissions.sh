#! /bin/bash
# fix permissions and other file issues
set -ouex pipefail

# Set nice for monado
/usr/bin/setcap CAP_SYS_NICE=eip /usr/bin/monado-service

# Edit Envision .desktop to force restart headset on start
desktop-file-edit --set-key="Exec" --set-value="/usr/bin/forceRestartIndex envision" "/usr/share/applications/org.gabmus.envision.Devel.desktop"

# fix index on boot
install -m 644 -o root -g root "/tmp/misc/udev/60-valve-index-reboot.rules" "/etc/udev/rules.d/60-valve-index-reboot.rules"
