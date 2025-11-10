#!/usr/bin/env bash

BAT_PATH="/sys/class/power_supply/BAT0"
ADP_PATH="/sys/class/power_supply/ADP1"

CHARGE=$(cat "$BAT_PATH/charge_now")
FULL=$(cat "$BAT_PATH/charge_full")
PERCENT=$(( CHARGE * 100 / FULL ))
ONLINE=$(cat "$ADP_PATH/online")

if [ "$ONLINE" -eq 1 ]; then
    STATUS="AC"
else
    STATUS="BAT"
fi

echo "${STATUS}${PERCENT}%"
echo
echo "#FFFFFF"

