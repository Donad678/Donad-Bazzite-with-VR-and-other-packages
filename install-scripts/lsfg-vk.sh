#!/usr/bin/env bash
set -euo pipefail

# Configuration
INDEX_URL="https://builds.lsfg-vk.dev/"
STAGING_DIR="/tmp/staging/usr"

echo "Fetching build index..."
HTML=$(curl -sL --fail --connect-timeout 10 --max-time 30 "${INDEX_URL}")

# Pull the href from the ">> Latest release (...) <<" row specifically
FILENAME=$(grep -oE '<a href="[^"]+">&gt;&gt; Latest release \([^)]*\) &lt;&lt;</a>' <<< "${HTML}" \
  | grep -oE 'href="[^"]+"' \
  | sed -E 's/href="([^"]+)"/\1/')

if [[ -z "${FILENAME:-}" ]]; then
    echo "Error: Could not find the 'Latest release' link on ${INDEX_URL}."
    exit 1
fi

DOWNLOAD_URL="${INDEX_URL}${FILENAME}"
echo "Latest release found: ${FILENAME}"

# Ensure the nested staging directory exists
mkdir -p "${STAGING_DIR}"
ARCHIVE_PATH="/tmp/lsfg-vk.tar.xz"

echo "Downloading asset from ${DOWNLOAD_URL}..."
curl -L --fail --connect-timeout 10 --max-time 300 --progress-bar "${DOWNLOAD_URL}" -o "${ARCHIVE_PATH}"

if [[ ! -s "${ARCHIVE_PATH}" ]]; then
    echo "Error: Download failed or file is empty."
    exit 1
fi

echo "Downloaded $(du -h "${ARCHIVE_PATH}" | cut -f1) to ${ARCHIVE_PATH}"

# Extracting with full path reporting
echo "Extracting archive to ${STAGING_DIR}..."
tar -xvf "${ARCHIVE_PATH}" -C "${STAGING_DIR}" --no-same-owner | sed "s|^\./|${STAGING_DIR}/|"

echo "Installation complete!"
