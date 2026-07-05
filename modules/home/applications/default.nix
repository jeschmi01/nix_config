{ pkgs, ... }: {

  home.packages = with pkgs; [
    telegram-desktop
    joplin-desktop
    obsidian
    nautilus
    sioyek
    zotero

    ghc
    hlint
  ];
}
