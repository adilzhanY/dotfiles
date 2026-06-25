#!/bin/sh

BASE="$HOME/.config/waybar"
THEMES="$BASE/themes"
STATE="$THEMES/.current"

mkdir -p "$THEMES"

if [ ! -f "$STATE" ]; then
  echo "" > "$STATE"
fi

ACTIVE=$(cat "$STATE")

LIST=$(ls -1 "$THEMES" | grep -v "^\.") 
NEXT=""
FOUND=false

for T in $LIST; do
  if [ "$FOUND" = true ]; then
    NEXT="$T"
    break
  fi
  if [ "$T" = "$ACTIVE" ]; then
    FOUND=true
  fi
done

if [ -z "$NEXT" ]; then
  NEXT=$(echo "$LIST" | head -n 1)
fi

echo "$NEXT" > "$STATE"

rm -f "$BASE/config.jsonc"
rm -f "$BASE/style.css"

ln -s "$THEMES/$NEXT/config.jsonc" "$BASE/config.jsonc"
ln -s "$THEMES/$NEXT/style.css" "$BASE/style.css"

pkill waybar
waybar &

