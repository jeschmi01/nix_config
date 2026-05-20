{ config, pkgs, ... }:
let
  runConf = "${config.xdg.cacheHome}/hyprlock_run.conf";

  lockScript = pkgs.writeShellScriptBin "dynamic-lock" '' 
    WALLPAPER=$(${pkgs.awww}/bin/awww query | ${pkgs.gawk}/bin/awk -F 'image: ' '{print $2}')

    ORIG_CONF="$HOME/.config/hypr/hyprlock.conf"
    RUN_CONF="${runConf}"

    mkdir -p "$(dirname "$RUN_CONF")"

    if [ -f "$ORIG_CONF" ]; then
        cp -f "$ORIG_CONF" "$RUN_CONF"
        chmod +w "$RUN_CONF"
    fi

    if [ -n "$WALLPAPER" ] && [ -f "$RUN_CONF" ]; then
        echo -e "\nbackground {\n    path = $WALLPAPER\n    blur_passes = 3\n    blur_size = 12\n    brightness = 0.5\n    noise = 0.0117\n    contrast = 0.8916\n}" >> "$RUN_CONF"
    fi 

    ${pkgs.hyprlock}/bin/hyprlock --config "$RUN_CONF"
  '';
in
{
  home.packages = [ lockScript ];
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        grace = 0;
      };

      background = [
        {
          path = "/home/placeholder.jpg";
          blur_passes = 3;
          blur_size = 12;
          brightness = 0.5;
          noise = 0.0117;
          contrast = 0.8916;
        }
      ];

      label = [
        {
          text = "$TIME";
          color = "rgb(207, 229, 232)";
          font_size = 120;
          font_family = "JetBrainsMono Nerd Font Bold";
          position = "0, 120";
          halign = "center";
          valign = "center";
          shadow_passes = 2;
          shadow_size = 3;
          zindex = 2;
        }
        {
          text = "cmd[update:1000] echo \"$(date +'%A, %d. %B')\"";
          color = "rgb(223, 167, 66)";
          font_size = 24;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 20";
          halign = "center";
          valign = "center";
          zindex = 2;
        }
      ];

      input-field = [
        {
          size = "250, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;

          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgb(207, 229, 232)";
          font_color = "rgb(44, 62, 65)";

          check_color = "rgb(223, 167, 66)";
          fail_color = "rgb(242, 143, 173)";

          shadow_passes = 1;
          shadow_size = 12;
          shadow_color = "rgba(207, 229, 232, 0.5)";

          fade_on_empty = false;
          rounding = 2;
          placeholder_text = "<span foreground='##2c3e41'><i>Password...</i></span>";

          position = "0, -100";
          halign = "center";
          valign = "center";
          zindex = 2;
        }
      ];
    };
  };
}
