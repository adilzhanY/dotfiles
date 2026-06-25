#!/usr/bin/env python3
"""Waybar memory module: combined "RAM% / VRAM%".

Bar text is "<ram>%/<vram>%" (e.g. 23%/76%); the tooltip breaks both down to
GB. VRAM comes from nvidia-smi; if there's no NVIDIA GPU the module gracefully
falls back to showing RAM only.
"""

import json
import shutil
import subprocess


def ram_usage():
    """Return (used_kib, total_kib) using the same notion as waybar: used =
    total - available."""
    info = {}
    with open("/proc/meminfo") as f:
        for line in f:
            key, _, rest = line.partition(":")
            info[key.strip()] = int(rest.strip().split()[0])  # value in kB
    total = info["MemTotal"]
    avail = info.get("MemAvailable", info.get("MemFree", 0))
    return total - avail, total


def vram_usage():
    """Return (used_mib, total_mib) for the first NVIDIA GPU, or None."""
    if not shutil.which("nvidia-smi"):
        return None
    try:
        out = subprocess.run(
            ["nvidia-smi", "--query-gpu=memory.used,memory.total",
             "--format=csv,noheader,nounits"],
            capture_output=True, text=True, timeout=4,
        ).stdout.strip().splitlines()
        if not out:
            return None
        used, total = (int(x.strip()) for x in out[0].split(","))
        return used, total
    except Exception:
        return None


def main():
    ru, rt = ram_usage()
    ram_pct = round(ru * 100 / rt)
    ram_used_gb = ru / 1024 / 1024
    ram_total_gb = rt / 1024 / 1024

    v = vram_usage()
    if v:
        vu, vt = v
        vram_pct = round(vu * 100 / vt)
        text = f"{ram_pct}%/{vram_pct}%"
        tooltip = (
            f"RAM:  {ram_used_gb:.1f} / {ram_total_gb:.1f} GB ({ram_pct}%)\n"
            f"VRAM: {vu / 1024:.1f} / {vt / 1024:.1f} GB ({vram_pct}%)"
        )
    else:
        text = f"{ram_pct}%"
        tooltip = f"RAM: {ram_used_gb:.1f} / {ram_total_gb:.1f} GB ({ram_pct}%)"

    print(json.dumps({"text": text, "tooltip": tooltip, "class": "memory"}))


if __name__ == "__main__":
    main()
