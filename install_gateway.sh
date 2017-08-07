#!/bin/bash

# Stop on the first sign of trouble
set -e

if [ $UID != 0 ]; then
    echo "ERROR: Operation not permitted. Forgot sudo?"
    exit 1
fi

echo "Install LoRaWAN Gateway"

git clone http://github.com/1gate/1G-LWG-COM-868-XXX
cd /home/ogate/1G-LWG-COM-868-XXX
./update_hostname.sh
cd /home/ogate/1G-LWG-COM-868-XXX/loriot
./install_loriot.sh
cd /home/ogate/1G-LWG-COM-868-XXX/semtech
./install_semtech.sh
cd /home/ogate/1G-LWG-COM-868-XXX/ttn
./install_ttn.sh
cd /home/ogate/tools
./rfs_ro.sh
cd
history -c
history -w

echo "The system will reboot in 5 seconds..."
sleep 5
shutdown -r now
