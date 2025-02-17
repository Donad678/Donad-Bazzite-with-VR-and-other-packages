#! /bin/bash

# install windows 95 for old games
curl -O /tmp/win95.rpm https://github.com/felixrieseberg/windows95/releases/download/v3.1.1/windows95-3.1.1-1.x86_64.rpm
dnf5 install -y /tmp/win95.rpm