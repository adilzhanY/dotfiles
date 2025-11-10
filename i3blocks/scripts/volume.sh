#!/usr/bin/env bash

# Get default sink (output device)
sink=$(pactl get-default-sink)

# Get human-readable device name
desc=$(pactl list sinks | grep -A2 "$sink" | grep "Description:" | cut -d: -f2- | xargs)

# Truncate description if too long
max_len=20
if [ ${#desc} -gt $max_len ]; then
  desc="${desc:0:$max_len}..."
fi

# Get volume and mute state
vol=$(pamixer --get-volume-human)
muted=$(pamixer --get-mute)

# Handle click (toggle mute)
if [[ "$BLOCK_BUTTON" -eq 1 ]]; then
  pamixer -t
fi

# Output with color for i3blocks
if [[ "$muted" == "true" ]]; then
  echo "$desc:OFF"
  echo "$desc:OFF"
  echo "#FF5555"  # red
else
  echo "$desc:$vol"
  echo "$desc:$vol"
  echo "#50FA7B"  # green
fi

