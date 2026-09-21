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
    (coq.withPackages (p: [
      p.stdlib
    ]))
    coqPackages.coq-lsp

    protonvpn-gui
  ];
}
