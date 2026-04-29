#!/usr/bin/env bash
set -euo pipefail

# Configuration
REPO="PancakeTAS/lsfg-vk"
STAGING_DIR="/tmp/staging/usr"

echo "Fetching latest prerelease info..."

# Find the download URL
DOWNLOAD_URL=$(curl -sL "https://api.github.com/repos/${REPO}/releases" | jq -r '
  map(select(.prerelease == true)) 
  | .[0].assets[] 
  | select(.name | test("linux\\.tar\\.xz$")) 
  | .browser_download_url
')

if [[ -z "$DOWNLOAD_URL" || "$DOWNLOAD_URL" == "null" ]]; then
    echo "Error: Could not find a matching tar.xz asset."
    exit 1
fi

# Ensure the nested staging directory exists
mkdir -p "${STAGING_DIR}"
ARCHIVE_PATH="/tmp/lsfg-vk.tar.xz"

echo "Downloading asset..."
curl -sL "${DOWNLOAD_URL}" -o "${ARCHIVE_PATH}"

# Extracting with full path reporting
# We use -v for verbose, but we'll pipe the output to ensure it looks exactly like the full path
echo "Extracting archive to ${STAGING_DIR}..."
tar -xvf "${ARCHIVE_PATH}" -C "${STAGING_DIR}" --no-same-owner | sed "s|^\./|${STAGING_DIR}/|"

echo "Installation complete!"
