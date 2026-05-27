{ pkgs, ... }: {
  home.packages = [
    pkgs.fastfetch
  ];

  xdg.configFile."fastfetch/config.jsonc".source = ./config.jsonc;
  xdg.configFile."fastfetch/sam.webp".source = ./sam.webp;

  home.shellAliases = {
    fetch = "clear && fastfetch";
    fastfetch = "clear && fastfetch";
  };
}
