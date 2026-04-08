#!/bin/bash
sed -i "1r $ICON_PATH" rofi-bluetooth

sed -i "s@devices=\$(bluetoothctl devices | grep Device | cut -d ' ' -f 3-)@devices=\$(bluetoothctl devices | grep Device | while read -r line; do mac=\$(echo \"\$line\" | cut -d ' ' -f 2); name=\$(echo \"\$line\" | cut -d ' ' -f 3-); icon=\$(get_icon \"\$mac\"); echo \"\$icon  \$name | \$mac\"; done)@" rofi-bluetooth

sed -i 's@device=\$(bluetoothctl devices | grep "\$chosen")@device=\$(bluetoothctl devices | grep "${chosen##*| }")@' rofi-bluetooth
