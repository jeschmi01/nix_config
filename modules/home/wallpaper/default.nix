{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    waypaper
  ];

  xdg.configFile."waypaper/config.ini" = {
    text =
      ''[Settings]
        language = de
        folder = ${config.home.homeDirectory}/.config/backgrounds/
        backend = swaybg       
        monitors = All
        fill = Fill
        sort = name
        color = #2c3e41
        subfolders = False
        show_hidden = False
        show_gifs = False     
        number_of_columns = 3
        post_command =
        zen_mode = True
        keybindings = ${config.home.homeDirectory}/.config/waypaper/keybindings.ini
      '';
    force = true;
  };

  xdg.configFile."waypaper/keybindings.ini".source = ./keybindings.ini;
  xdg.configFile."gtk-3.0/gtk.css".source = ./style.css;
}
