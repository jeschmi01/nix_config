{ lib, ... }:
{
  programs.kitty = {
    enable = true;
    keybindings = {
      "ctrl+shift+9" = "next_window";
      "ctrl+shift+8" = "previous_window";
    };
    settings = {
      background = "#15241C";
      background_blur = "5";
      background_opacity = "0.8";

      hide_window_decorations = "yes";

      font_size = "14";
      foreground = "#c8e0e4";

      window_padding_width = 10;
      active_tab_foreground = "#29210a";
      active_tab_background = "#dfa742";
      active_tab_font_style = "bold";
      active_tab_title_template = "{index}: {title} ";


      inactive_tab_foreground = "#264d3f";
      inactive_tab_background = "#cfe5e8";
      inactive_tab_font_style = "normal";

      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";

      tab_bar_margin_height = "5.0 0.0";
      tab_bar_margin_width = "5.0";
      tab_title_template = "{fmt.fg._223d9d}{activity_symbol}{fmt.fg.default}{index}:{title}";
      tab_activity_symbol = "󱐋 ";
    };
  };
}
