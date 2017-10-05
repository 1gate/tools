#!/bin/bash

# Stop on the first sign of trouble
set -e

if [ $UID != 0 ]; then
    echo "ERROR: Operation not permitted. Forgot sudo?"
    exit 1
fi

echo "Install Mosquitto as systemd service"

systemctl stop mosquitto
update-rc.d mosquitto remove
rm /etc/init.d/mosquitto
cp /tools/mosquitto/mosquitto.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable mosquitto
systemctl start mosquitto


#echo "The system will reboot in 5 seconds..."
#sleep 5
#shutdown -r now
