#!/bin/bash

# Get current submap from hyprctl
submap=$(hyprctl -j activewindow | jq -r '.submap')

# If there's no submap or it's "reset", print nothing
if [[ "$submap" == "null" || "$submap" == "reset" ]]; then
  echo ""
else
  echo "[$submap]"
fi
