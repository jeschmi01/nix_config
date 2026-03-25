{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./../../modules/nixos
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Zeit- und Regionaleinstellungen für Deutschland
  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # X11 und Desktop (GNOME)
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.generic.environment = { };

  # Tastaturlayout auf Deutsch konfigurieren
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Konsolen-Layout (für das Terminal außerhalb von GNOME)
  console.keyMap = "de";

  # Wichtig für Laptops: Touchpad-Unterstützung
  services.libinput.enable = true;

  services.printing.enable = true;

  # Audio (Pipewire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  # Benutzer-Account
  users.users.jenny = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Jennifer Schmidt";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.zsh.enable = true;

  programs.firefox = {
    enable = true;
    languagePacks = [ "de" ];
  };

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    fastfetch
    nixd
    wl-clipboard
    nixpkgs-fmt
    kitty
    fortune
    cowsay
  ];

  system.stateVersion = "24.11";
}
