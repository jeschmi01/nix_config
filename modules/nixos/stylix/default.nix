{ pkgs, lib, ... }:
{
  stylix = {
    enable = true;
    image = ./metalgear.jpg;
    base16Scheme = ./schema.yaml;
    imageScalingMode = "fill";
    polarity = "dark";
    targets.gnome.enable = true;
    targets.gtk.enable = true;
    targets.qt.enable = false;
  };
}

