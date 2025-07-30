#!/usr/bin/env bash
set -euo pipefail

REPO="PancakeTAS/lsfg-vk"

# Get the RPM download URL from the latest release
DOWNLOAD_URL=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" \
  | jq -r '.assets[] | select(.name | test("\\.rpm$")) | .browser_download_url' \
  | head -n 1)

if [[ -z "$DOWNLOAD_URL" ]]; then
  echo "❌ No RPM file found in the latest release of $REPO"
  exit 1
fi

FILENAME=$(basename "$DOWNLOAD_URL")

echo "📥 Downloading $FILENAME..."
curl -L -o "$FILENAME" "$DOWNLOAD_URL"

echo "📦 Installing $FILENAME..."
dnf5 install -y ./"$FILENAME"

echo "✅ Installation LSFG-VK installation complete."
