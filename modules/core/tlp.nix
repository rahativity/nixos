{
  config,
  pkgs,
  ...
}: {
  services.tlp = {
    enable = true;
    settings = {
      # General
      TLP_AUTO_SWITCH = 1;
      TLP_DEFAULT_MODE = "AC";

      # CPU driver mode (amd-pstate: active | passive | guided)
      CPU_DRIVER_OPMODE_ON_AC = "active";
      CPU_DRIVER_OPMODE_ON_BAT = "active";
      CPU_DRIVER_OPMODE_ON_SAV = "active";

      # CPU governor (amd-pstate active mode exposes performance/powersave)
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_SCALING_GOVERNOR_ON_SAV = "powersave";

      # Energy perf policy
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_SAV = "power";

      # CPU performance limits
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50;
      CPU_MIN_PERF_ON_SAV = 0;
      CPU_MAX_PERF_ON_SAV = 40;

      # Boost
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_BOOST_ON_SAV = 0;

      # Platform profile
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";
      PLATFORM_PROFILE_ON_SAV = "low-power";

      # PCIe Active State Power Management (ASPM) & Runtime PM
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

      # AMD Radeon iGPU (amdgpu driver)
      AMDGPU_DPM_PERF_LEVEL_ON_AC = "auto";
      AMDGPU_DPM_PERF_LEVEL_ON_BAT = "low";
      AMDGPU_DPM_PERF_LEVEL_ON_SAV = "low";
      AMDGPU_ABM_LEVEL_ON_AC = 0;
      AMDGPU_ABM_LEVEL_ON_BAT = 4;

      # Devices
      DEVICES_TO_ENABLE_ON_STARTUP = "wifi bluetooth";
      DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth nfc wwan";
    };
  };
}
