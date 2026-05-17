{ ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading = true;
        hide_cursor = true;
        grace = 0;
        no_fade_in = false;
      };

      background = [
        {
          path = "~/.config/backgrounds/metalgear.jpg";
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
