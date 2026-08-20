{
  pkgs,
  config,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = ["v4l2loopback"];
    extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
    extraModprobeConfig = ''
      options btusb enable_autosuspend=0
      options mt7921e disable_aspm=1
    '';
    kernelParams = [
      "amd_pstate=active" # Ensure AMD P-State active/autonomous mode
      "pcie_aspm=off" # Forcibly disable PCIe ASPM to override BIOS lock and prevent MT7922 packet drops
      "btusb.enable_autosuspend=n" # Prevent USB autosuspend on btusb at kernel level
      "mt7921e.disable_aspm=1" # Disable ASPM on MediaTek MT7922 Wi-Fi/BT combo card
    ];
    kernel.sysctl = {"vm.max_map_count" = 2147483642;};
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
    plymouth.enable = false;
  };
}
