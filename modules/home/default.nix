{ ... }:
{
  imports = [
    ./zsh.nix
    ./kitty.nix
    ./starship.nix
    ./hypridle.nix

    ./applications
    ./fastfetch
    ./fuzzel
    ./gtk
    ./hyprlock
    ./lazyvim
    ./niri
    ./rofi
    ./waybar
    ./waypaper
  ];
}
