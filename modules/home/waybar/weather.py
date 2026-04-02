#!/usr/bin/env python3
import subprocess
import json
import os

def get_weather():
    try:
        text = subprocess.check_output(
            ["curl", "-s", "wttr.in/Dortmund?format=%c+%t&lang=de"], 
            encoding="utf-8"
        ).strip()

        tooltip = subprocess.check_output(
            ["curl", "-s", "wttr.in/Dortmund?0QT&lang=de"], 
            encoding="utf-8"
        ).strip()

        print(json.dumps({
            "text": text,
            "tooltip": tooltip
        }))

    except Exception:
        # Fehler-Fallback
        print(json.dumps({"text": "󰖐 Fehler", "tooltip": "Wetter konnte nicht geladen werden"}))

if __name__ == "__main__":
    get_weather()
