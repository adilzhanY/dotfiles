#!/bin/bash

DEVICE="B4:84:D5:99:5F:AB" # JBL MAC

STATUS=$(bluetoothctl info $DEVICE | grep "Connected" | awk '{print $2}')
BATTERY_HEX=$(bluetoothctl info $DEVICE | grep "Battery" | awk '{print $3}')

if [ "$STATUS" = "yes" ]; then
    if [ -z "$BATTERY_HEX" ]; then
        echo ""
    else
        # Convert hex to decimal
        BATTERY=$((BATTERY_HEX))
        echo " $BATTERY%"
    fi
else
    echo ""
fi

