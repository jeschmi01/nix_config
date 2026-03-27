{ ... }:

{
  xdg.configFile."niri/config.kdl" = {
    text = ''
      input {
          keyboard {
              xkb {
                  layout "de"
              }
          }
      }

      output "eDP-1" {
          mode "1920x1080@60"
          scale 1.0
      }

      binds {
          "Mod+T" { spawn "kitty"; }
          "Mod+Q" { close-window; }
          "Mod+F" { maximize-column; }
        
          "Mod+Shift+F" { fullscreen-window; }

          "Mod+R" { switch-preset-column-width; }
      }
    '';
    force = true;
  };
}
