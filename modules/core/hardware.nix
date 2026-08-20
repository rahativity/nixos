{pkgs, ...}: {
  hardware = {
    sane = {
      enable = true;
      extraBackends = [pkgs.sane-airscan];
      disabledDefaultBackends = ["escl"];
    };
    logitech.wireless.enable = false;
    graphics.enable = true;
    enableRedistributableFirmware = true;
    keyboard.qmk.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true; # Battery level reporting
          FastConnectable = false; # Prevents page scan firmware lockups on MT7922
          JustWorksRepairing = "always";
          MultiProfile = "multiple";
        };
        Policy = {
          AutoEnable = true;
          ReconnectAttempts = 7;
          ReconnectIntervals = "1, 2, 4, 8, 16, 32, 64";
        };
      };
    };
  };

  # Prevent kernel USB autosuspend from putting MediaTek Bluetooth controller to sleep
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0e8d", ATTR{idProduct}=="223c", ATTR{power/control}="on"
    ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="btusb", ATTR{power/control}="on"
  '';

  local.hardware-clock.enable = false;
}
