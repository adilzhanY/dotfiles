#!/usr/bin/env bash

mic=$(pactl get-default-source)
desc=$(pactl list sources | grep -A2 "$mic" | grep "Description:" | cut -d: -f2- | xargs)
muted=$(pactl list sources | grep -A10 "$mic" | grep "Mute:" | awk '{print $2}')

# Truncate description if it's too long
max_len=20
if [ ${#desc} -gt $max_len ]; then
  desc="${desc:0:$max_len}..."
fi

# Left click toggles mute
if [[ "$BLOCK_BUTTON" -eq 1 ]]; then
  pactl set-source-mute "$mic" toggle
fi

# Output text and color for i3blocks
if [[ "$muted" == "yes" ]]; then
  echo "$desc:OFF"
  echo "$desc:OFF"
  echo "#FF5555"  # red
else
  echo "$desc:ON"
  echo "$desc:ON"
  echo "#50FA7B"  # green
fi

