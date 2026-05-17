#!/usr/bin/env python3
import subprocess
import json
import re

WEATHER_SYMBOLS = {
    "✨": "󱐋",
    "☁️": "󰖐", "☁": "󰖐",
    "🌫️": "󰖑", "🌫": "󰖑",
    "🌧️": "󰖗", "🌧": "󰖗",
    "❄️": "󰼶", "❄": "󰼶",
    "🌦️": "󰖕", "🌦": "󰖕",
    "🌨️": "󰼴", "🌨": "󰼴",
    "⛅️": "󰖕", "⛅": "󰖕",
    "☀️": "󰖙", "☀": "󰖙",
    "🌩️": "󰖓", "🌩": "󰖓",
    "⛈️": "󰙾", "⛈": "󰙾"
}

def get_weather():
    try:
        raw = subprocess.check_output(
            ["curl", "-s", "wttr.in/Dortmund?format=%c|%t&lang=de"], 
            encoding="utf-8"
        ).strip()
        
        if "|" not in raw:
            raise ValueError("Unexpected format received from wttr.in")

        condition_emoji, temp = raw.split("|")
        condition_emoji = condition_emoji.strip()

        icon = WEATHER_SYMBOLS.get(condition_emoji)
        if not icon:
            clean_emoji = condition_emoji.replace("\ufe0f", "")
            icon = WEATHER_SYMBOLS.get(clean_emoji, condition_emoji)

        tooltip = subprocess.check_output(
            ["curl", "-s", "wttr.in/Dortmund?0QT&lang=en"], 
            encoding="utf-8"
        )
        
        print(json.dumps({
            "text": f"{icon} {temp}",
            "tooltip": tooltip
        }))

    except Exception as e:
        print(json.dumps({
            "text": "󰖐 --°C", 
            "tooltip": f"Error: {str(e)}"
        }))

if __name__ == "__main__":
    get_weather()
