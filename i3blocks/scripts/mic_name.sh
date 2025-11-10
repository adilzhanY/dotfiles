#!/usr/bin/env bash

# Get default mic
mic=$(pactl get-default-source)

# Get human-readable description
desc=$(pactl list sources | grep -A2 "$mic" | grep "Description:" | cut -d: -f2- | xargs)

# Get volume and mute state
vol=$(pactl list sources | grep -A10 "$mic" | grep "Volume:" | head -n1 | awk '{print $5}')
muted=$(pactl list sources | grep -A10 "$mic" | grep "Mute:" | awk '{print $2}')

icon=""
[ "$muted" = "yes" ] && icon=""


# Optional: also export for tooltip
echo "$desc"
