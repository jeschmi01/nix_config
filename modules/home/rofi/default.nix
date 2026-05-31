{ pkgs, lib, config, ... }:

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
  imports = [
    ./rofi-bluetooth.nix
  ];

  home.packages = [
    pkgs.pwmenu
    pkgs.rofi-network-manager
    pkgs.libqalculate
    pkgs.hyprlock
    rofi-power-menu-custom
  ];

  programs.rofi = {
    enable = true;

    package = pkgs.rofi.override {
      plugins = [
        pkgs.rofi-calc
      ];
    };

    theme = lib.mkForce ./theme.rasi;

    modes = [ ];

    extraConfig = {
      modi = "drun,run,window,ssh,calc,power-menu:rofi-power-menu";
    };
  };
}
