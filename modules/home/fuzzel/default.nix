{ pkgs, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:weight=bold:size=11";
        width = 35;
        tabs = 8;
        horizontal-pad = 10;
        vertical-pad = 10;
        inner-pad = 5;
      };

      colors = {
        background = "cfe5e8ff";
        text = "2c3e41ff";
        match = "dfa742ff";
        selection = "dfa742ff";
        selection-text = "121212ff";
        border = "2c3e41ff";
      };

      border = {
        width = 2;
        radius = 2;
      };
    };
  };
}
