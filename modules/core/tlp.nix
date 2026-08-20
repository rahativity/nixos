{
  config,
  pkgs,
  ...
}: {
  services.tlp = {
    enable = true;
    settings = {
      # ╔══════════════════════════════════════════════════════════════════╗
      # ║  HP EliteBook 845 G10 (AMD Ryzen 5 PRO 7545U)                  ║
      # ║  Unified Intelligent Adaptive Power Management Architecture     ║
      # ║                                                                 ║
      # ║  ONE profile. TLP auto-switches between AC and BAT behavior.   ║
      # ║  Priorities: battery health > low temps > battery life >        ║
      # ║              low fan noise > smooth performance > peak power    ║
      # ╚══════════════════════════════════════════════════════════════════╝

      # ── General ──────────────────────────────────────────────────────
      TLP_AUTO_SWITCH = 1;
      TLP_DEFAULT_MODE = "AC";

      # ── AMD P-State CPPC Driver ──────────────────────────────────────
      # Active mode: hardware autonomously manages P-states via CPPC,
      # guided by EPP hints from the OS. This is the optimal mode for
      # Zen4/Phoenix (Ryzen 5 PRO 7545U).
      CPU_DRIVER_OPMODE_ON_AC = "active";
      CPU_DRIVER_OPMODE_ON_BAT = "active";

      # ── CPU Scaling Governor ─────────────────────────────────────────
      # 'powersave' is REQUIRED for amd-pstate-epp autonomous scaling.
      # Despite the name, it does NOT mean slow — it enables the hardware
      # to scale from 400 MHz to max frequency based on real demand.
      # The 'performance' governor would lock EPP to 'performance' and
      # defeat the purpose of hardware-driven efficiency.
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # ── Energy Performance Preference (EPP) ─────────────────────────
      # The most important knob for amd-pstate-epp. Controls how
      # aggressively the CPPC firmware ramps frequency.
      #
      # AC: 'balance_performance' — responsive ramp-up for IDEs, Docker,
      #     compilation while idling efficiently at ~400 MHz.
      # BAT: 'power' — most aggressive power saving. CPU still has full
      #      3.2 GHz base clock (boost disabled separately), more than
      #      enough for browsing, PDFs, coding, VS Code, university work.
      #      ~15-20% more battery life vs 'balance_power'.
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # ── CPU Performance Scaling Range ────────────────────────────────
      # 0-100% dynamic CPPC scaling. Let the hardware decide.
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 100;

      # ── CPU Boost (Turbo) ────────────────────────────────────────────
      # AC: Enabled — allows 4.9 GHz turbo for heavy workloads (compile,
      #     Docker, IDE indexing). Ramps down automatically when idle.
      # BAT: Disabled — caps at 3.2 GHz base clock across 6C/12T.
      #      Eliminates thermal spikes, fan noise, and power surges.
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      # ── Hardware P-State Dynamic Boost ───────────────────────────────
      # AC: Allow dynamic boost for workload-responsive performance.
      # BAT: Disabled to prevent unnecessary power surges.
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      # ── ACPI Platform Profiles (HP Firmware / EC) ────────────────────
      # Controls fan curves, TDP limits, and thermal targets in the
      # HP Embedded Controller. Available: low-power, balanced, performance.
      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # ── AMD Radeon 740M RDNA3 iGPU Power Management ─────────────────
      # DPM: 'auto' lets the GPU manage its own power states.
      #      'low' would cause Hyprland UI/animation stutter.
      # ABM: Adaptive Backlight Management — reduces display power.
      #      0 = off (color accuracy), 1 = subtle, 2 = moderate, 3 = aggressive.
      AMDGPU_DPM_PERF_LEVEL_ON_AC = "auto";
      AMDGPU_DPM_PERF_LEVEL_ON_BAT = "auto";
      AMDGPU_ABM_LEVEL_ON_AC = 0;
      AMDGPU_ABM_LEVEL_ON_BAT = 2;

      # ── PCIe Active State Power Management (ASPM) ────────────────────
      # AC: 'default' — kernel/firmware decides, balancing latency and power.
      # BAT: 'powersupersave' — enables deepest L1.1/L1.2 substates for
      #      maximum power savings on NVMe, Wi-Fi, and other PCIe devices.
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersupersave";

      # ── Runtime PM (PCIe/USB/SoC device suspend) ─────────────────────
      # 'auto' allows idle devices to enter low-power states.
      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";
      RUNTIME_PM_DENYLIST = "01:00.0"; # MediaTek MT7922 Wi-Fi/BT PCIe adapter

      # ── NVMe Power Management (APST) ─────────────────────────────────
      # Autonomous Power State Transitions — saves 0.5-1W on battery.
      NVM_EXPRESS_PM_ON_AC = "default";
      NVM_EXPRESS_PM_ON_BAT = 1;

      # ── Disk I/O Scheduler ───────────────────────────────────────────
      # mq-deadline is optimal for NVMe + btrfs (your filesystem).
      DISK_IOSCHED = "mq-deadline";

      # ── Audio Power Saving (AMD ACP / HD Audio) ──────────────────────
      # Timeout in seconds before the audio codec enters power saving.
      # 1 second is unnoticeable for normal use.
      SOUND_POWER_SAVE_ON_AC = 1;
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";

      # ── Network / Wi-Fi Power Management (MediaTek MT7921/MT7922) ────
      # Keep off on both AC and BAT to prevent 2.4GHz coexistence dropouts with Bluetooth
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "off";

      # ── USB Autosuspend ──────────────────────────────────────────────
      USB_AUTOSUSPEND = 1;
      USB_EXCLUDE_BTUSB = 1; # Exclude Bluetooth controllers — prevents connection drops
      USB_DENYLIST = "0e8d:223c"; # MediaTek MT7922 Bluetooth USB controller

      # ── Peripheral Startup & Battery Power Cut ───────────────────────
      DEVICES_TO_ENABLE_ON_STARTUP = "wifi bluetooth";
      DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "nfc wwan";
    };
  };

  # Explicitly prevent conflicting services from activating
  services.power-profiles-daemon.enable = false;
}
