{ pkgs, lib, config, ... }:

let
  patched-rofi-bluetooth = pkgs.rofi-bluetooth.overrideAttrs (oldAttrs: {
    postPatch = ''
      export ICON_PATH=${./icons.sh}
      bash ${./patch-rofi-bluetooth.sh}
    '';
  });
in
{
  home.packages = with pkgs; [
    (pkgs.writeShellScriptBin "rofi-bluetooth" ''
      if pgrep -x rofi > /dev/null; then
        pkill -x rofi
        exit 0
      fi

      ${patched-rofi-bluetooth}/bin/rofi-bluetooth \
        -theme ${./theme.rasi} \
        -p " Bluetooth"
    '')

    bluez
    bc
  ];
}
