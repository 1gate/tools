#!/bin/bash

# Stop on the first sign of trouble
set -e

if [ $UID != 0 ]; then
    echo "ERROR: Operation not permitted. Forgot sudo?"
    exit 1
fi

echo "1GATE / lora_gateway / util_tx_test"

if [ $(systemctl is-active lorawan-server) ]; then
	systemctl stop lorawan-server
fi

if [ $(systemctl is-active loriot) ]; then
	systemctl stop loriot
fi

if [ $(systemctl is-active semtech) ]; then
	systemctl stop semtech
fi

if [ $(systemctl is-active ttn) ]; then
	systemctl stop ttn
fi

cd /opt/semtech/lora_gateway
./reset_lgw.sh start 25

cd /opt/semtech/lora_gateway/util_tx_test
./util_tx_test -f 868.300 -r 1257

cd

#echo "The system will reboot in 5 seconds..."
#sleep 5
#shutdown -r now
