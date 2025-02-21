#! /bin/bash

# curl https://raw.githubusercontent.com/virtualhere/script/main/install_server | sh

wget https://www.virtualhere.com/sites/default/files/usbserver/vhusbdx86_64
chmod +x vhusbdx86_64
mv vhusbdx86_64 /usr/bin
if [ -d "/etc/systemd/system" ]; then
  cat << EOF > /etc/systemd/system/virtualhere.service
[Unit]
Description=VirtualHere Server
After=network.target

[Service]
Type=forking
ExecStart=/usr/bin/vhusbdx86_64 -b -c /usr/local/etc/virtualhere/config.ini

[Install]
WantedBy=multi-user.target
EOF

systemctl enable virtualhere.service