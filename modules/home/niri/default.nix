{ config, pkgs, ... }:

{
  home.file.".config/niri/config.kdl" = {
    source = ./config.kdl;
    force = true;
  };

  home.activation = {
    restoreWallpaper = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.waypaper}/bin/waypaper --restore &
    '';
  };
}
