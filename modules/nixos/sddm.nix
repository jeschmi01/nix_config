{ pkgs, lib, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    wayland.enable = lib.mkForce true;

    theme = "sddm-astronaut-theme";

    extraPackages = [
      pkgs.sddm-astronaut
    ];
  };

  environment.systemPackages = [
    pkgs.sddm-astronaut
  ];
}
