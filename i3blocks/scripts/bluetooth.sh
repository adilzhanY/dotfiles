#!/bin/bash

DEVICE="B4:84:D5:99:5F:AB"  # JBL MAC

STATUS=$(bluetoothctl info "$DEVICE" | grep "Connected" | awk '{print $2}')
BATTERY_HEX=$(bluetoothctl info "$DEVICE" | grep "Battery" | awk '{print $3}')

COLOR_CONNECTED="#00AFFF"
COLOR_DISCONNECTED="#555555"

if [ "$STATUS" = "yes" ]; then
    if [ -z "$BATTERY_HEX" ]; then
        TEXT="BT:connected"
    else
        BATTERY=$((BATTERY_HEX))
        TEXT="BT:${BATTERY}%"
    fi
    COLOR="$COLOR_CONNECTED"
else
    TEXT="BT:off"
    COLOR="$COLOR_DISCONNECTED"
fi

echo "$TEXT"
echo
echo "$COLOR"

