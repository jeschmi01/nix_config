{ pkgs, ... }:

let
  rofi-display-picker = pkgs.writeShellScriptBin "rofi-display-picker" ''
    INT="eDP-1"
    EXT="HDMI-A-4"

    INT_ON=$(${pkgs.niri}/bin/niri msg --json outputs | ${pkgs.jq}/bin/jq -r ".[] | select(.name==\"$INT\") | .is_active")
    EXT_ON=$(${pkgs.niri}/bin/niri msg --json outputs | ${pkgs.jq}/bin/jq -r ".[] | select(.name==\"$EXT\") | .is_active")

    CURRENT_ROW=0
    if [ "$INT_ON" = "true" ] && [ "$EXT_ON" = "false" ]; then
        CURRENT_ROW=0
    elif [ "$INT_ON" = "false" ] && [ "$EXT_ON" = "true" ]; then
        CURRENT_ROW=1
    elif [ "$INT_ON" = "true" ] && [ "$EXT_ON" = "true" ]; then
        CURRENT_ROW=2
    fi

    OPTIONS="󰍹 Laptop Screen Only\n󰍺 External Monitor Only\n󰹑 Extend Desktop\n󰦛 Reset Display Layout"
    CHOICE=$(echo -e "$OPTIONS" | ${pkgs.rofi}/bin/rofi -dmenu -i -selected-row "$CURRENT_ROW" -p "󰐚 Display Mode:")

    case "$CHOICE" in
        *Laptop*)
            ${pkgs.niri}/bin/niri msg output "$INT" on
            ${pkgs.niri}/bin/niri msg output "$EXT" off
            ;;
        *External*)
            ${pkgs.niri}/bin/niri msg output "$EXT" on
            ${pkgs.niri}/bin/niri msg output "$INT" off
            ;;
        *Extend*)
            ${pkgs.niri}/bin/niri msg output "$INT" on
            ${pkgs.niri}/bin/niri msg output "$EXT" on
            ;;
        *Reset*)
            ${pkgs.niri}/bin/niri msg output "$INT" on
            ${pkgs.niri}/bin/niri msg output "$EXT" on
            ;;
    esac
  '';
in
{
  home.packages = [
    pkgs.jq
    rofi-display-picker
  ];
}
