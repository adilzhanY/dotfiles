#!/usr/bin/env bash

# Extract the earliest package installation timestamp
if [ -f /var/log/pacman.log ]; then
    install_date=$(grep -m1 "installed" /var/log/pacman.log | grep -oP '\[\K[0-9]{4}-[0-9]{2}-[0-9]{2}')
else
    install_date=$(date "+%Y-%m-%d")
fi

# Fallback if empty
if [ -z "$install_date" ]; then
    install_date=$(date "+%Y-%m-%d")
fi

# Current date
current_date=$(date "+%Y-%m-%d")

# Convert to seconds
install_sec=$(date -d "$install_date" +%s)
current_sec=$(date -d "$current_date" +%s)

# Calculate difference in days
diff_days=$(( (current_sec - install_sec) / 86400 ))

echo "${diff_days} days"

