{
  pkgs,
  zaneyos ? {},
  ...
}: let
  isNoctalia = (zaneyos.barChoice or "") == "noctalia";
  lockCmd =
    if isNoctalia
    then "${pkgs.noctalia}/bin/noctalia msg session lock"
    else "${pkgs.hyprlock}/bin/hyprlock";
in {
  services = {
    hypridle = {
      enable = true;
      systemdTarget = "hyprland-session.target";
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = lockCmd;
        };
        listener = [
          {
            timeout = 900;
            on-timeout = lockCmd;
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };
}
