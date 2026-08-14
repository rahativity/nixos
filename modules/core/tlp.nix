{
  config,
  pkgs,
  host,
  ...
}: let
  vars = import ../../hosts/${host}/variables.nix;
  luffy = vars.luffyMode;
in {
  services.tlp = {
    enable = true;
    settings = {
      # General
      TLP_AUTO_SWITCH = 1;
      TLP_DEFAULT_MODE = "AC";

      # ╔══════════════════════════════════════════════════════════════════╗
      # ║  TLP Power Profiles                                            ║
      # ║  Controlled by variables.nix:                                  ║
      # ║  🐒 luffyMode  = true  → Balanced (power when you need it)    ║
      # ║  🦌 chopperMode = true → Battery Saver (cool & quiet)         ║
      # ╚══════════════════════════════════════════════════════════════════╝

      # CPU driver mode
      CPU_DRIVER_OPMODE_ON_AC = "active";
      CPU_DRIVER_OPMODE_ON_BAT = "active";

      # CPU governor
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # Energy perf policy
      CPU_ENERGY_PERF_POLICY_ON_AC =
        if luffy
        then "performance"
        else "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT =
        if luffy
        then "balance_power"
        else "power";

      # CPU performance limits
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT =
        if luffy
        then 100
        else 50;

      # Boost
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT =
        if luffy
        then 1
        else 0;

      # Platform profile
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT =
        if luffy
        then "balanced"
        else "low-power";

      # AMD Radeon iGPU
      AMDGPU_DPM_PERF_LEVEL_ON_AC = "auto";
      AMDGPU_DPM_PERF_LEVEL_ON_BAT =
        if luffy
        then "auto"
        else "low";
      AMDGPU_ABM_LEVEL_ON_AC = 0;
      AMDGPU_ABM_LEVEL_ON_BAT =
        if luffy
        then 2
        else 4;

      # ╔══════════════════════════════════════════════════════════════════╗
      # ║  Shared Settings (apply to both profiles)                      ║
      # ╚══════════════════════════════════════════════════════════════════╝

      # PCIe Active State Power Management & Runtime PM
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersave";
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";

      # Audio Power Saving
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";

      # Wi-Fi Power Saving
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      # USB Autosuspend
      USB_AUTOSUSPEND = 1;

      # Devices
      DEVICES_TO_ENABLE_ON_STARTUP = "wifi bluetooth";
      DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth nfc wwan";
    };
  };
}
