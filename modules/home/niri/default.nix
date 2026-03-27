{ config, pkgs, ... }:

{
  imports = [
    ./waybar.nix
  ];

  xdg.configFile."niri/config.kdl" = {
    force = true;
    text = ''
      ${builtins.readFile ./config.kdl}
      spawn-at-startup "${pkgs.swaybg}/bin/swaybg" "-i" "${config.stylix.image}" "-m" "fill"
    '';
  };
}
