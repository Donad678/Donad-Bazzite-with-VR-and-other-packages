#!/usr/bin/env bash
set -euo pipefail

REPO="PancakeTAS/lsfg-vk"
STAGING_DIR="/tmp/staging"

echo "Fetching latest prerelease info for ${REPO}..."

# Find the download URL via GitHub API
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

# Prepare Staging Area
mkdir -p "${STAGING_DIR}"
ARCHIVE_PATH="${STAGING_DIR}/lsfg-vk.tar.xz"

echo "Downloading asset to ${STAGING_DIR}..."
curl -sL "${DOWNLOAD_URL}" -o "${ARCHIVE_PATH}"

# Extract into the staging directory
echo "Extracting archive..."
tar -xvf "${ARCHIVE_PATH}" -C "${STAGING_DIR}" --no-same-owner

echo "Installation complete!"
