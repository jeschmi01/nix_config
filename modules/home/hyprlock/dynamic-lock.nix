{ config, pkgs, ... }:
let
  lockScript = pkgs.writeShellScriptBin "dynamic-lock" '' 
    WALLPAPER=$(${pkgs.awww}/bin/awww query | ${pkgs.gawk}/bin/awk -F 'image: ' '{print $2}')
    RUN_CONF="${config.xdg.cacheHome}/hyprlock_run.conf"
    ORIG_CONF="$HOME/.config/hypr/hyprlock.conf"

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
lockScript
