{ pkgs, ... }:

let
  rofi-power-menu-custom = pkgs.writeShellScriptBin "rofi-power-menu" ''
    if [ -z "$1" ]; then
        echo -e "󰌾 Lock screen\n󰒲 Suspend\n󰍃 Log out\n󰜉 Reboot\n󰐥 Shut down"
        exit 0
    fi

    case "$1" in
        *"Lock screen")
            dynamic-lock > /dev/null 2>&1
            ;;
        *"Suspend")
            systemctl suspend
           ;;
        *"Log out")
            niri msg action quit
            ;;
        *"Reboot")
            systemctl reboot
            ;;
        *"Shut down")
            systemctl poweroff
            ;;
    esac
  '';
in
{
  home.packages = [
    rofi-power-menu-custom
  ];
}
