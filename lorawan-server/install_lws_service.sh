#!/bin/bash

# Stop on the first sign of trouble
set -e

if [ $UID != 0 ]; then
    echo "ERROR: Operation not permitted. Forgot sudo?"
    exit 1
fi

echo "Install lorawan-server as systemd service"

cp tools/lorawan-server/lorawan-server.service /etc/systemd/system/

#echo "The system will reboot in 5 seconds..."
#sleep 5
#shutdown -r now
