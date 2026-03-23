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
    opacity = {
      terminal = 0.8;
      applications = 0.8;
      desktop = 0.8;
    };
    fonts = {
      sizes = {
        terminal = 14; # Setzt Kitty, Alacritty, etc.
        applications = 12; # Setzt GUI Apps (Browser Menüs, etc.)
        desktop = 12; # Setzt die Panel/Bar Größe
      };
    };
  };
}

