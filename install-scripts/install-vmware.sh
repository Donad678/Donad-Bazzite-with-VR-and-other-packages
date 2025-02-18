#! /bin/bash

wget -O /tmp/vmware.bundle https://stream.donadvr.de/public/vmware-workstation-pro-17.bundle

EULAS_AGREED=1 /tmp/binaries/vmware-workstation-pro-17.bundle --deferred-gtk --console 
