#!/bin/bash

disk_info=$(df -h /home | awk 'NR==2 {print $2,$3,$4,$5}')
total=$(echo $disk_info | awk '{print $1}')
used=$(echo $disk_info | awk '{print $2}')
free=$(echo $disk_info | awk '{print $3}')
percent_used=$(echo $disk_info | awk '{print $4}')
percent_free=$((100 - ${percent_used%\%}))


COLOR="#FFA500"  # orange

# i3blocks format:
# 1st line: text
# 2nd line: short text (optional)
# 3rd line: color
echo "$free"B""
echo
echo "$COLOR"

