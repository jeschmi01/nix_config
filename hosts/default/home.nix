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
    fuzzel
    waybar
    swaybg
    xwayland
    nodePackages.vscode-langservers-extracted
    nodePackages.prettier
    stylelint
    tailwindcss-language-server
  ];


  home.shellAliases = {
    update = "sudo nixos-rebuild switch --flake /etc/nixos/#nixos";
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

  stylix.targets.kitty.enable = false;
}
