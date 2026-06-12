{ pkgs, lib, config, ... }:
{
  imports = [
    ./rofi-bluetooth.nix
    ./rofi-power-menu.nix
    ./rofi-display-picker.nix
  ];

  home.packages = [
    pkgs.pwmenu
    pkgs.rofi-network-manager
    pkgs.libqalculate
    pkgs.hyprlock
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
