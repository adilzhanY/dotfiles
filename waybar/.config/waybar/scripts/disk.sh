#!/usr/bin/env bash
# Root filesystem usage for waybar in "<used>/<total>GB" form (e.g. 12/191GB).
# `/` and `/home` share the same partition on this machine, so `/` covers it.
# Emits JSON (text + tooltip) for a custom module with "return-type": "json".

read -r used total pct avail < <(
  df -BG --output=used,size,pcent,avail / \
    | awk 'NR==2 { gsub("G","",$1); gsub("G","",$2); gsub("G","",$4); print $1, $2, $3, $4 }'
)

text="${used}/${total}GB"
tooltip="Used: ${used}GB / ${total}GB (${pct})\nFree: ${avail}GB"

printf '{"text": "%s", "tooltip": "%s", "class": "disk"}\n' "$text" "$tooltip"
