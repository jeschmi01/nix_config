{ pkgs, lib, ... }:

{
  home.username = "jenny";
  home.homeDirectory = "/home/jenny";

  imports = [
    ../../modules/home
  ];
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    nixd
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    xwayland
    prettier
    stylelint
    tailwindcss-language-server
    rust-analyzer
    rustc
    cargo
    rustfmt
    gcc
    jq
    libnotify

    (writeShellScriptBin "update" ''
      cd "$HOME/Projekte/nix_config"
      git add .
      sudo nixos-rebuild switch --flake .#nixos
    '')
  ];

  home.shellAliases = {
    ll = "ls -l";
    chuck =
      let
        chuckData = pkgs.runCommand "chuck-norris-data" { nativeBuildInputs = [ pkgs.fortune ]; } ''
          mkdir -p $out
          cp ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/chucknorris/fortunes/chucknorris $out/
          strfile $out/chucknorris $out/chucknorris.dat
        '';
      in
      "${pkgs.fortune}/bin/fortune ${chuckData}/chucknorris";

    chuck_cow = "chuck | ${pkgs.cowsay}/bin/cowsay";
  };


  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Jennifer Schmidt";
        email = "schmidtjennifer01@gmail.com";
      };
      init.defaultBranch = "master";
    };
  };

  gtk.gtk4.theme = null;

  qt = {
    enable = true;
    platformTheme.name = lib.mkForce "adwaita";
  };


  programs.waybar.systemd.targets = [ "niri-session.target" ];
}
