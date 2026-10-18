{pkgs, ...}:
pkgs.writeShellScriptBin "hyprland-toggle-vibrance" ''
  SHADER="$HOME/.config/hypr/shaders/vibrance.glsl"
  CURRENT=$(hyprctl getoption decoration:screen_shader -j 2>/dev/null | ${pkgs.jq}/bin/jq -r '.str // ""')

  if [ -n "$CURRENT" ] && [ "$CURRENT" != "[[EMPTY]]" ]; then
    hyprctl eval 'hl.config({ decoration = { screen_shader = "" } })' >/dev/null 2>&1
    ${pkgs.libnotify}/bin/notify-send -t 2000 "Display Vibrance" "Disabled screen shader"
  else
    hyprctl eval 'hl.config({ decoration = { screen_shader = "'"$SHADER"'" } })' >/dev/null 2>&1
    ${pkgs.libnotify}/bin/notify-send -t 2000 "Display Vibrance" "Enabled vibrance & contrast shader"
  fi
''
