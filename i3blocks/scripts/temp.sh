#!/bin/bash
TEMP=$(cat /sys/class/thermal/thermal_zone8/temp)
printf "%d°C\n" $((TEMP / 1000))

