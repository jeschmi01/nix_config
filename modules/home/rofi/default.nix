{ pkgs, lib, config, ... }:

{
  imports = [
    ./rofi-bluetooth.nix
  ];

  home.packages = [
    pkgs.libqalculate
  ];
  programs.rofi = {
    enable = true;
    package = pkgs.rofi.override {
      plugins = [ pkgs.rofi-calc ];
    };
    theme = lib.mkForce ./theme.rasi;
    modes = [
      "drun"
      "run"
      "window"
      "ssh"
      "calc"
    ];
  };
}
