{ ... }:
{
  nix.settings.auto-optimise-store = true;
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    flake = "./nix_config#nixos";
    dates = "daily";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  hardware.cpu.intel.updateMicrocode = true;
  services.fwupd.enable = true;
  services.fstrim.enable = true;
}
