{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    waypaper
  ];

  home.file.".config/backgrounds" = {
    source = ./../../../backgrounds;
    recursive = true;
  };

  xdg.configFile."waypaper/config.ini" = {
    text =
      ''[Settings]
        language = de
        folder = ${config.home.homeDirectory}/.config/backgrounds/
        backend = awww       
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

        swww_transition_type = center
        swww_transition_step = 90
        swww_transition_angle = 0
        swww_transition_duration = 2
        swww_transition_fps = 60
      '';
    force = true;
  };

}
