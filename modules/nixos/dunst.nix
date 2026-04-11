{ ... }: {

  services.dunst = {
    enable = true;
    settings = {
      "ignore_ibus_popup" = {
        appname = "IBus";
        summary = "IBus Benachrichtigung";
        skip_display = true;
      };

      global = {
        font = "JetBrainsMono Nerd Font Bold 11";
        startup_notification = false;

        width = 300;
        height = "(0, 200)";
        origin = "top-right";
        offset = "(10, 0)";
        layer = "overlay";

        padding = 12;
        horizontal_padding = 12;
        frame_width = 2;
        corner_radius = 2;

        separator_color = "frame";
      };

      urgency_low = {
        background = "#000000";
        foreground = "#cfe5e8";
        frame_color = "#2c3e41";
        timeout = 5;
      };

      urgency_normal = {
        background = "#dfa742";
        foreground = "#121212";
        frame_color = "#2c3e41";
        timeout = 10;
      };

      urgency_critical = {
        background = "#000000";
        foreground = "#dfa742";
        frame_color = "#ff0000";
        timeout = 0;
      };
    };
  };
}
