#!/usr/bin/env python3
"""Event-driven keyboard-layout indicator for Waybar.

Prints a short label (ENG/RUS/DEU/KAZ) the instant the layout changes,
by listening to Hyprland's socket2 event stream instead of polling.
"""
import os
import socket
import sys

LABELS = {
    "English (US)": "ENG",
    "Russian": "RUS",
    "German": "DEU",
    "Kazakh": "KAZ",
}


def label(keymap: str) -> str:
    return LABELS.get(keymap, keymap)


def current_keymap() -> str:
    """Read the active keymap once via hyprctl (used for the initial value)."""
    import json
    import subprocess

    try:
        out = subprocess.run(
            ["hyprctl", "devices", "-j"], capture_output=True, text=True, check=True
        ).stdout
        for kb in json.loads(out).get("keyboards", []):
            if kb.get("main"):
                return kb.get("active_keymap", "")
    except Exception:
        pass
    return ""


def emit(keymap: str) -> None:
    print(label(keymap), flush=True)


def main() -> None:
    sig = os.environ.get("HYPRLAND_INSTANCE_SIGNATURE")
    runtime = os.environ.get("XDG_RUNTIME_DIR", f"/run/user/{os.getuid()}")
    if not sig:
        # No Hyprland: fall back to a single read so the bar isn't blank.
        emit(current_keymap())
        return

    sock_path = os.path.join(runtime, "hypr", sig, ".socket2.sock")

    # Initial value.
    emit(current_keymap())

    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    sock.connect(sock_path)
    buf = b""
    with sock.makefile("rb") as f:
        for raw in f:
            line = raw.decode(errors="replace").strip()
            # Format: "activelayout>>KEYBOARD_NAME,Layout Name"
            if line.startswith("activelayout>>"):
                data = line[len("activelayout>>"):]
                # Keyboard name may itself contain commas; layout is after the last.
                keymap = data.rsplit(",", 1)[-1]
                emit(keymap)


if __name__ == "__main__":
    try:
        main()
    except (KeyboardInterrupt, BrokenPipeError):
        sys.exit(0)
