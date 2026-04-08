{ pkgs, lib, config, ... }:

let
  icons = builtins.readFile ./icons.sh;
  patched-rofi-bluetooth = pkgs.rofi-bluetooth.overrideAttrs (oldAttrs: {
    postPatch = ''
      export ICON_PATH=${./icons.sh}
      bash ${./patch-rofi-bluetooth.sh}
    '';
  });
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = lib.mkForce ./theme.rasi;
  };

  home.packages = with pkgs; [
    (pkgs.writeShellScriptBin "rofi-bluetooth" ''
      # Falls offen, dann schließen
      if pgrep -x rofi > /dev/null; then
        pkill -x rofi
        exit 0
      fi

      # Startet das gepatchte Original mit deinem dunklen Prompt [#2c3e41]
      ${patched-rofi-bluetooth}/bin/rofi-bluetooth \
        -theme ${./theme.rasi} \
        -p " Bluetooth"
    '')

    bluez
    bc
  ];
}
