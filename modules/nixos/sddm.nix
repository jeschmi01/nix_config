{ pkgs, ... }:

let
  custom-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "pixel_sakura";
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    wayland.enable = false;
    theme = "sddm-astronaut-theme";
    extraPackages = [ custom-astronaut ];
  };

  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  i18n.defaultLocale = "de_DE.UTF-8";
  console.keyMap = "de";

  environment.systemPackages = [ custom-astronaut ];
}
