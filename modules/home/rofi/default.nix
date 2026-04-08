{ pkgs, lib, config, ... }:

let
  rofi-bluetooth-script = pkgs.writeShellScriptBin "rofi-bluetooth" ''
    # 1. TOGGLE: Falls offen, dann schließen
    if pgrep -x rofi > /dev/null; then
      pkill -x rofi
      exit 0
    fi

    # HILFSFUNKTIONEN
    get_status() {
      ${pkgs.bluez}/bin/bluetoothctl show | grep "$1" | cut -d ' ' -f 2
    }

    get_icon() {
      local mac=$1
      local type=$(${pkgs.bluez}/bin/bluetoothctl info "$mac" | grep "Icon:" | cut -d ' ' -f 2)
      case "$type" in
        audio-card|audio-headphones|audio-headset) echo "󰋋" ;; # Kopfhörer
        input-mouse) echo "󰍽" ;;                             # Maus
        input-keyboard) echo "󰌌" ;;                          # Tastatur
        phone) echo "󰏲" ;;                                   # Smartphone
        *) echo "󰂯" ;;                                       # Standard
      esac
    }

    # 2. STATUS ABFRAGEN
    power=$(get_status "Powered:")
    scan=$(get_status "Discovering:")
    pairable=$(get_status "Pairable:")
    discoverable=$(get_status "Discoverable:")

    # GERÄTELISTE MIT ICONS BAUEN
    device_list=$(${pkgs.bluez}/bin/bluetoothctl devices | while read -r line; do
        mac=$(echo "$line" | cut -d ' ' -f 2)
        name=$(echo "$line" | cut -d ' ' -f 3-)
        icon=$(get_icon "$mac")
        echo -e "$icon  $name | $mac"
    done)

    # MENÜ-TEXTE
    opt_power="Power: $power"
    opt_scan="Scan: $scan"
    opt_pair="Pairable: $pairable"
    opt_disc="Discoverable: $discoverable"

    # 3. ROFI AUFRUFEN (Dunkler Prompt [#2c3e41])
    chosen=$(echo -e "$device_list\n---------\n$opt_power\n$opt_scan\n$opt_pair\n$opt_disc" | \
      ${pkgs.rofi}/bin/rofi -dmenu \
        -p " Bluetooth" \
        -theme ${./theme.rasi} \
        -i)

    # 4. AKTIONEN VERARBEITEN
    case "$chosen" in
      "$opt_power")
        [[ "$power" == "yes" ]] && ${pkgs.bluez}/bin/bluetoothctl power off || ${pkgs.bluez}/bin/bluetoothctl power on
        sleep 0.5 && exec rofi-bluetooth ;;
      "$opt_scan")
        if [[ "$scan" == "yes" ]]; then
          ${pkgs.bluez}/bin/bluetoothctl scan off
        else
          ${pkgs.bluez}/bin/bluetoothctl scan on &
        fi
        sleep 1 && exec rofi-bluetooth ;;
      "$opt_pair")
        [[ "$pairable" == "yes" ]] && ${pkgs.bluez}/bin/bluetoothctl pairable off || ${pkgs.bluez}/bin/bluetoothctl pairable on
        exec rofi-bluetooth ;;
      "$opt_disc")
        [[ "$discoverable" == "yes" ]] && ${pkgs.bluez}/bin/bluetoothctl discoverable off || ${pkgs.bluez}/bin/bluetoothctl discoverable on
        exec rofi-bluetooth ;;
      *" | "*)
        mac_addr=$(echo "$chosen" | cut -d '|' -f 2 | xargs)
        if ${pkgs.bluez}/bin/bluetoothctl info "$mac_addr" | grep -q "Connected: yes"; then
          ${pkgs.bluez}/bin/bluetoothctl disconnect "$mac_addr"
        else
          ${pkgs.bluez}/bin/bluetoothctl connect "$mac_addr"
        fi ;;
    esac
  '';
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = lib.mkForce ./theme.rasi;
  };

  home.packages = [
    rofi-bluetooth-script
    pkgs.rofi
    pkgs.bluez
  ];
}
