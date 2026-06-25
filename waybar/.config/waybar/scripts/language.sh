#!/usr/bin/env bash

layout=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main) | .active_keymap' | head -n 1)

case "$layout" in
  "English (US)") icon="🇺🇸" ;;
  "Russian") icon="🇷🇺" ;;
  "German") icon="🇩🇪" ;;
  "Kazakh") icon="🇰🇿" ;;
  *) icon="$layout" ;;
esac

echo "$icon"

