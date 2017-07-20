#!/bin/bash

# Stop on the first sign of trouble
set -e

if [ $UID != 0 ]; then
    echo "ERROR: Operation not permitted. Forgot sudo?"
    exit 1
fi

echo "Set Root File System in Read Write Mode"

umount /boot
mount /dev/mmcblk0p1 /boot
sed -i "s,init=/sbin/overlayRoot.sh,init=/sbin/init" /boot/cmdline.txt

echo "The system will reboot in 5 seconds..."
sleep 5
shutdown -r now
