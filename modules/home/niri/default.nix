{ config, pkgs, ... }:
{
  wayland.windowManager.niri.enable = true;

  wayland.windowManager.niri.settings = {
    input = {
      keyboard.xkb.layout = "de";
      touchpad = {
        tap = true;
        dwt = true;
      };
    };

    layout = {
      gaps = 12;
      center-focused-column = "never";
      default-column-width = { proportion = 0.5; };

      focus-ring = {
        enable = true;
        width = 2;
        active.color = "rgba(127, 204, 255, 1.0)";
      };
    };

    spawn-at-startup = [
      { command = [ "${pkgs.swaybg}/bin/swaybg" "-m" "fill" "-i" "../../nixos/stylix/metalgear.jpg" ]; }
      { command = [ "${pkgs.waybar}/bin/waybar" ]; }
    ];

    binds = {
      "Mod+Return".action.spawn = [ "kitty" ];
      "Mod+D".action.spawn = [ "fuzzel" ];
      "Mod+Q".action.close-window = [ ];

      "Mod+Left".action.focus-column-left = [ ];
      "Mod+Right".action.focus-column-right = [ ];
      "Mod+Shift+Left".action.move-column-left = [ ];
      "Mod+Shift+Right".action.move-column-right = [ ];

      "Mod+WheelScrollDown".action.focus-column-right = [ ];
      "Mod+WheelScrollUp".action.focus-column-left = [ ];

      "Mod+Shift+E".action.quit = [ ];
    };
  };
}


