#!/usr/bin/env bash

layout=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main) | .active_keymap' | head -n 1)

# Just print the layout exactly as reported by Hyprland
echo "$layout"

