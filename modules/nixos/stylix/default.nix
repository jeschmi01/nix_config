{ ... }:
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
        terminal = 14;
        applications = 12;
        desktop = 12;
      };
    };
  };
}

