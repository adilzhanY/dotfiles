#!/usr/bin/env python3
"""Waybar module: connected devices and their battery levels.

Bar shows a USB icon; the tooltip lists every connected device we can find,
with its battery percentage where available. Battery data is gathered from:

  * headsetcontrol  -> gaming headsets (HyperX, SteelSeries, Logitech, ...)
  * upower          -> Bluetooth / HID peripherals (mice, keyboards, headsets)

Devices that are physically connected but don't expose a battery level (e.g.
a headset model headsetcontrol doesn't support yet) are still listed, shown as
"n/a", so the tooltip reflects what's actually plugged in.
"""

import glob
import json
import os
import shutil
import subprocess

ICON = ""  # nf-fa-usb


def run(cmd):
    try:
        return subprocess.run(
            cmd, capture_output=True, text=True, timeout=5
        ).stdout
    except Exception:
        return ""


def from_headsetcontrol(devices):
    if not shutil.which("headsetcontrol"):
        return
    try:
        data = json.loads(run(["headsetcontrol", "-o", "json"]) or "{}")
    except json.JSONDecodeError:
        return
    for d in data.get("devices", []):
        name = d.get("product") or d.get("device") or "Headset"
        batt = d.get("battery", {}) or {}
        status = batt.get("status")
        level = batt.get("level")
        if status == "BATTERY_AVAILABLE" and isinstance(level, int) and level >= 0:
            devices.append((name, f"{level}%"))
        elif status == "BATTERY_CHARGING":
            devices.append((name, "charging"))
        else:
            devices.append((name, "n/a"))


def from_upower(devices):
    if not shutil.which("upower"):
        return
    for path in run(["upower", "-e"]).split():
        if "DisplayDevice" in path or "line_power" in path:
            continue
        info = {}
        for line in run(["upower", "-i", path]).splitlines():
            key, sep, val = line.strip().partition(":")
            if sep:
                info[key.strip()] = val.strip()
        # Skip internal/system batteries; we only want peripherals.
        if info.get("power supply") == "yes":
            continue
        pct = info.get("percentage")
        if not pct:
            continue
        name = info.get("model") or os.path.basename(path)
        devices.append((name, pct))


def hyperx_fallback(devices):
    """List the HyperX dongle even if headsetcontrol can't read its battery."""
    have = " ".join(n.lower() for n, _ in devices)
    for product_file in glob.glob("/sys/bus/usb/devices/*/product"):
        try:
            product = open(product_file).read().strip()
        except OSError:
            continue
        low = product.lower()
        if ("hyperx" in low or "cloud" in low) and "cloud" not in have and "hyperx" not in have:
            devices.append((product, "n/a"))
            return


def main():
    devices = []
    from_headsetcontrol(devices)
    from_upower(devices)
    hyperx_fallback(devices)

    # De-duplicate while preserving order.
    seen = set()
    unique = []
    for name, batt in devices:
        if name not in seen:
            seen.add(name)
            unique.append((name, batt))

    if unique:
        tooltip = "\n".join(f"{name}: {batt}" for name, batt in unique)
    else:
        tooltip = "No connected devices found"

    print(json.dumps({"text": ICON, "tooltip": tooltip, "class": "devices"}))


if __name__ == "__main__":
    main()
