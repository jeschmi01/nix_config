{ ... }:
{

  home.file.".local/share/fonts/batmfa.ttf".source = ./../../../assets/batmfa__.ttf;
  home.file.".local/share/fonts/batmfo.ttf".source = ./../../../assets/batmfo__.ttf;
  home.file.".config/waybar/scripts/weather.py".source = ./weather.py;

  fonts.fontconfig.enable = true;

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    style = builtins.readFile ./style.css;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        exclusive = true;
        height = 35;

        modules-left = [ "niri/workspaces" "cpu" "memory" ];
        modules-center = [ "clock" "custom/weather" ];
        modules-right = [ "tray" "bluetooth" "network" "backlight" "pulseaudio" "battery" ];


        "cpu" = {
          interval = 10;
          format = " {}%";
          max-length = 10;
        };

        "memory" = {
          interval = 30;
          format = "  {used:0.1f}G/{total:0.1f}G";
        };

        "clock" = {
          format = "󰃭 {:%d.%m.%Y - %H:%M}";
          tooltip = true;
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click = "mode";
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "custom/weather" = {
          format = { };
          return-type = "json";
          interval = 3600;
          exec = "python3 ~/.config/waybar/scripts/weather.py";
        };

        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = [ "󰃞" "󰃟" "󰃠" ];
        };

        "battery" = {
          states = {
            "warning" = 30;
            "critical" = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };


        "bluetooth" =
          {
            format = " {status}";
            format-disabled = "";
            format-connected = " {num_connections} connected";
            tooltip-format = "{controller_alias}\t{controller_address}";
            tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
            tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
            on-click = "blueman-manager";
          };



        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-icons = {
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };

        "network" = {
          format = "{ifname}";
          format-wifi = "  {essid} ({signalStrength}%) ";
          format-ethernet = "󰛳 {ipaddr}/{cidr} ";
          format-disconnected = "⚠ Disconnected";
          tooltip-format = "{ifname} via {gwaddr} 󰛳";
          tooltip-format-wifi = "  {essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "󰛳 {ifname}";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          on-click = "nm-connection-editor";
        };
      };
    };
  };

}
