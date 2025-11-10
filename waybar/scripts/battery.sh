#!/usr/bin/env bash

BAT_PATH="/sys/class/power_supply/BAT0"
ADP_PATH="/sys/class/power_supply/ADP1"

# Read values
CHARGE=$(cat "$BAT_PATH/charge_now")
FULL=$(cat "$BAT_PATH/charge_full")
PERCENT=$(( CHARGE * 100 / FULL ))

# Check if charger is online
ONLINE=$(cat "$ADP_PATH/online")

# Choose icon based on percentage
if [ "$PERCENT" -le 20 ]; then
    ICON=""
elif [ "$PERCENT" -le 40 ]; then
    ICON=""
elif [ "$PERCENT" -le 60 ]; then
    ICON=""
elif [ "$PERCENT" -le 80 ]; then
    ICON=""
else
    ICON=""
fi

# Override icon if charging
if [ "$ONLINE" -eq 1 ]; then
    ICON="⚡"
    CLASS="charging"
else
    CLASS="discharging"
fi

# Output for Waybar
echo "$ICON $PERCENT%"

