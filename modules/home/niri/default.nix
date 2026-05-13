{ config, pkgs, ... }:

{
  home.file.".config/niri/config.kdl" = {
    force = true;
    text = ''
      ${builtins.readFile ./config.kdl}
      spawn-at-startup "${pkgs.swaybg}/bin/swaybg" "-i" "${../../../assets/metalgear.jpg}" "-m" "fill"
    '';
  };
}
