#! /bin/bash
curl -s https://api.github.com/repos/Zagrios/bs-manager/releases/latest \
| grep "browser_download_url.*rpm" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -O /tmp/bsmanager.rpm -qi -

dnf5 install -y /tmp/bsmanager.rpm