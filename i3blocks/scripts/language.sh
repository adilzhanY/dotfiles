#!/usr/bin/env bash
export DISPLAY=:0
export XAUTHORITY=/home/qantr/.Xauthority

# Detect current layout
if command -v xkb-switch >/dev/null 2>&1; then
  current=$(xkb-switch)
else
  current=$(setxkbmap -query | awk '/layout/ {print $2}' | cut -d',' -f1)
fi

# Map layout to flag
case "$current" in
  us) flag="🇬🇧" ;;  # UK flag instead of US
  ru) flag="🇷🇺" ;;
  de) flag="🇩🇪" ;;
  kz|kk) flag="🇰🇿" ;;
  *) flag="🏳️" ;;
esac

# Background and text color (customize these)
bg="#44475a"    # dark gray
fg="#f8f8f2"    # light text

# Output with pango markup
echo "<span background='$bg' foreground='$fg'>[$flag]</span>"

