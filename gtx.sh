#!/bin/bash

# Stop on the first sign of trouble
set -e

if [ $UID != 0 ]; then
    echo "ERROR: Operation not permitted. Forgot sudo?"
    exit 1
fi

echo "1GATE / lora_gateway / util_tx_test"

if [ $(systemctl -q is-active lorawan-server) ]; then
	systemctl stop lorawan-server
	exit 1
fi

if [ $(systemctl -q is-active loriot) ]; then
	systemctl stop loriot
	exit 1
fi

if [ $(systemctl -q is-active semtech) ]; then
	systemctl stop semtech
	exit 1
fi

if [ $(systemctl -q is-active ttn) ]; then
	systemctl stop ttn
	exit 1
fi

cd /opt/semtech/lora_gateway
./reset_lgw.sh start 25

cd /opt/semtech/lora_gateway/util_tx_test
./util_tx_test -f 868.100 -r 1257

echo "The system will reboot in 5 seconds..."
sleep 5
shutdown -r now
