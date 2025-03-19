#! /bin/bash

# curl https://raw.githubusercontent.com/virtualhere/script/main/install_server | sh

wget https://www.virtualhere.com/sites/default/files/usbserver/vhusbdx86_64
chmod +x vhusbdx86_64
mv vhusbdx86_64 /usr/bin
if [ -d "/etc/systemd/system" ]; then
  cp /tmp/misc/virtualhere.service /etc/systemd/system/virtualhere.service
fi
# systemctl enable virtualhere.service