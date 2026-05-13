{ pkgs, lib, ... }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      screenshots = true;
      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";
      clock = true;
      indicator = true;
      indicator-radius = 120;
      indicator-thickness = 10;

      inside-color = lib.mkForce "2c3e41cc";
      inside-ver-color = lib.mkForce "2c3e41";
      inside-wrong-color = lib.mkForce "2c3e41";
      ring-color = lib.mkForce "cfe5e8";
      ring-ver-color = lib.mkForce "dfa742";
      ring-wrong-color = lib.mkForce "f28fad";
      key-hl-color = lib.mkForce "dfa742";
      text-color = lib.mkForce "cfe5e8";
      date-color = lib.mkForce "cfe5e8";
      layout-text-color = lib.mkForce "cfe5e8";
      line-color = lib.mkForce "00000000";
      separator-color = lib.mkForce "00000000";
    };
  };
}
