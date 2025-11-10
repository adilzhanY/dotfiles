#!/bin/bash

DEVICE="B4:84:D5:99:5F:AB"
STATUS=$(bluetoothctl info $DEVICE | grep "Connected" | awk '{print $2}')

if [ "$STATUS" = "yes" ]; then
    bluetoothctl disconnect $DEVICE
else
    bluetoothctl connect $DEVICE
fi

