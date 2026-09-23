#!/bin/bash
set -ouex pipefail

# Resolve latest x86_64 RPM URL from the GitHub API
url=$(curl -fsSL https://api.github.com/repos/koharu-rs/koharu/releases/latest \
  | grep -oP '"browser_download_url":\s*"\K[^"]+\.x86_64\.rpm' \
  | head -n1)

[ -n "$url" ] || { echo "No x86_64 RPM found in latest koharu release" >&2; exit 1; }

curl -fsSL -o /tmp/koharu.rpm "$url"
dnf5 install -y /tmp/koharu.rpm
rm -f /tmp/koharu.rpm
