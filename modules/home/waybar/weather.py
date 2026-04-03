#!/usr/bin/env python3
import subprocess
import json
import re

# Mapping: Emoji -> Nerd Font Icon
# Ich habe hier beide Varianten (Text- und Grafik-Emoji) für die wichtigsten Keys hinterlegt
WEATHER_SYMBOLS = {
    "✨": "󱐋",
    "☁️": "󰖐", "☁": "󰖐",
    "🌫": "󰖑",
    "🌧": "󰖗",
    "❄️": "󰼶", "❄": "󰼶",
    "🌦": "󰖕",
    "🌨": "󰼴",
    "⛅️": "󰖕", "⛅": "󰖕",
    "☀️": "󰖙", "☀": "󰖙",
    "🌩": "󰖓",
    "⛈": "󰙾"
}

def get_weather():
    try:
        # Abfrage von Icon und Temperatur
        raw = subprocess.check_output(
            ["curl", "-s", "wttr.in/Dortmund?format=%c|%t&lang=de"], 
            encoding="utf-8"
        ).strip()
        
        if "|" not in raw:
            raise ValueError("Unerwartetes Format von wttr.in")

        condition_emoji, temp = raw.split("|")
        condition_emoji = condition_emoji.strip()

        # WICHTIG: Entferne den Variation Selector (\ufe0f), falls vorhanden,
        # damit das Mapping robuster ist.
        clean_emoji = condition_emoji.replace("\ufe0f", "")

        # Suche in der Map mit dem bereinigten Emoji
        icon = WEATHER_SYMBOLS.get(clean_emoji, condition_emoji)

        # Tooltip abrufen
        tooltip = subprocess.check_output(
            ["curl", "-s", "wttr.in/Dortmund?0QT&lang=de"], 
            encoding="utf-8"
        )
        
        print(json.dumps({
            "text": f"{icon} {temp}",
            "tooltip": tooltip
        }))

    except Exception as e:
        print(json.dumps({"text": "󰖐 --°C", "tooltip": f"Fehler: {str(e)}"}))

if __name__ == "__main__":
    get_weather()
