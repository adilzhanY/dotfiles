#!/usr/bin/env python3
import json
import time
import os

BAT_PATH = "/sys/class/power_supply/BAT0"
UPDATE_INTERVAL = 2  # seconds

# Icon thresholds (manually distributed)
ICONS = ["", "", "", "", ""]  # 0-20%, 21-40%, 41-60%, 61-80%, 81-100%

def get_battery_info():
    with open(os.path.join(BAT_PATH, "capacity")) as f:
        capacity = int(f.read().strip())
    with open(os.path.join(BAT_PATH, "status")) as f:
        status = f.read().strip()
    with open(os.path.join(BAT_PATH, "voltage_now")) as f:
        voltage = int(f.read().strip()) / 1_000_000  # microvolts to volts
    return capacity, status, voltage

def get_icon(capacity):
    if capacity <= 20:
        return ICONS[0]
    elif capacity <= 40:
        return ICONS[1]
    elif capacity <= 60:
        return ICONS[2]
    elif capacity <= 80:
        return ICONS[3]
    else:
        return ICONS[4]

def get_color(capacity):
    if capacity >= 65:
        return "#a3be8c"  # green
    elif capacity >= 20:
        return "#ebcb8b"  # yellow
    else:
        return "#bf616a"  # red

while True:
    capacity, status, voltage = get_battery_info()
    icon = get_icon(capacity)
    battery_class = "charging" if status.lower() == "charging" else "discharging"
    color = get_color(capacity)

    output = {
        "text": f"{icon} {capacity}% | {status} | {voltage:.2f}V",
        "class": battery_class,
        "tooltip": f"Battery: {capacity}%\nStatus: {status}\nVoltage: {voltage:.2f}V",
        "color": color
    }

    print(json.dumps(output))
    # Flush so Waybar updates
    print("", flush=True)
    time.sleep(UPDATE_INTERVAL)

