{profile, ...}: {
  # Services to start
  services = {
    upower.enable = true; # noctalia shell battery
    libinput.enable = true; # Input Handling
    fstrim.enable = true; # SSD Optimizer
    gvfs.enable = true; # For Mounting USB & More
    #howdy.enable = true; # For Touchpad Gestures
    #mako.enable = true;
    cloudflare-warp.enable = true;


    openssh = {
      enable = true; # Enable SSH
      settings = {
        PermitRootLogin = "no"; # Prevent root from SSH login
        PasswordAuthentication = true; #Users can SSH using kb and password
        KbdInteractiveAuthentication = true;
      };
      ports = [22];
    };

    blueman.enable = true; # Bluetooth Support
    tumbler.enable = true; # Image/video preview
    gnome.gnome-keyring.enable = true;

    smartd = {
      enable =
        if profile == "vm"
        then false
        else true;
      autodetect = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 1024;
          "default.clock.min-quantum" = 256;
          "default.clock.max-quantum" = 2048;
        };
      };
      extraConfig.pipewire-pulse."92-low-latency" = {
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "256/48000";
              pulse.default.req = "1024/48000";
              pulse.max.req = "2048/48000";
              pulse.min.quantum = "256/48000";
              pulse.max.quantum = "2048/48000";
            };
          }
        ];
      };
      wireplumber.extraConfig = {
        "10-bluetooth" = {
          "monitor.bluez.properties" = {
            "bluez5.codecs" = ["sbc" "aac"];
            "bluez5.enable-sbc-xq" = false;
            "bluez5.enable-msbc" = true;
            "bluez5.enable-hw-volume" = true;
            "bluez5.roles" = ["a2dp_source" "hsp_ag" "hfp_ag"];
          };
          "monitor.bluez.rules" = [
            {
              matches = [
                {
                  "node.name" = "~bluez_output.*";
                }
              ];
              actions = {
                update-props = {
                  "session.suspend-timeout-seconds" = 0;
                };
              };
            }
            {
              matches = [
                {
                  "node.name" = "~bluez_input.*";
                }
              ];
              actions = {
                update-props = {
                  "session.suspend-timeout-seconds" = 0;
                };
              };
            }
          ];
          "wireplumber.settings" = {
            "bluetooth.autoswitch-to-headset-profile" = false;
          };
        };
      };
    };
  };
}
