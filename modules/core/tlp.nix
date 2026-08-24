{
  config,
  pkgs,
  ...
}: {
  services.tlp = {
    enable = true;
    settings = {
      # ╔══════════════════════════════════════════════════════════════════╗
      # ║  HP EliteBook 845 G10 — AMD Ryzen 5 PRO 7545U (Zen4/Phoenix)  ║
      # ║  Battery Health & Persistent Cool Operation Profile            ║
      # ║                                                                 ║
      # ║  Single TLP profile with automatic AC ↔ BAT switching.         ║
      # ║  Both states are tuned for efficiency and low thermals.         ║
      # ║  Priorities: battery health > thermals > fan silence >         ║
      # ║              battery life > smooth UX > peak performance       ║
      # ╚══════════════════════════════════════════════════════════════════╝

      # ── General ──────────────────────────────────────────────────────
      TLP_AUTO_SWITCH = 1;
      TLP_DEFAULT_MODE = "AC";

      # ══════════════════════════════════════════════════════════════════
      # ██  BATTERY CARE — CHARGE THRESHOLDS                           ██
      # ══════════════════════════════════════════════════════════════════
      # HP EliteBook 845 G10 does NOT expose charge threshold sysfs
      # interfaces (tlp-stat -b → plugin: generic, features: none).
      # TLP's START/STOP_CHARGE_THRESH_BAT0 have NO effect on this
      # hardware. Configure charge limits in firmware instead:
      #
      #   BIOS (F10 at boot) → Power → Battery Health Manager
      #     → "Maximize my battery health" (targets ~80% max SoC)
      #
      # At 100 cycles / 90.2% capacity, enabling this ASAP will
      # significantly slow further calendar and cycle degradation.

      # ── AMD P-State CPPC Driver ──────────────────────────────────────
      # 'active' mode: hardware autonomously manages P-states via CPPC,
      # guided by EPP hints from the OS. Optimal for Zen4/Phoenix.
      CPU_DRIVER_OPMODE_ON_AC = "active";
      CPU_DRIVER_OPMODE_ON_BAT = "active";

      # ── CPU Scaling Governor ─────────────────────────────────────────
      # 'powersave' is REQUIRED for amd-pstate-epp. Despite the name,
      # it enables full hardware-driven frequency scaling (400 MHz → max).
      # 'performance' would override EPP and waste power.
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # ── Energy Performance Preference (EPP) ─────────────────────────
      # AC:  'balance_power' — prioritizes efficiency over responsiveness.
      #      CPU still ramps for sustained loads but favors lower P-states
      #      at idle. Eliminates unnecessary frequency spikes during light
      #      tasks (browsing, terminals, text editing, VS Code).
      # BAT: 'power' — most aggressive power saving. CPU stays at lowest
      #      feasible P-state unless load demands otherwise. Still provides
      #      3.2 GHz base clock — more than enough for daily work.
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # ── CPU Performance Scaling Range ────────────────────────────────
      # Capped at 80% on BOTH states to limit sustained power draw and
      # thermals. On the 7545U this still allows ~3.9 GHz — more than
      # enough for daily tasks with boost disabled. The cap primarily
      # prevents sustained all-core loads from exceeding the quiet
      # thermal envelope of the low-power platform profile.
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 80;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 80;

      # ── CPU Boost (Turbo) ────────────────────────────────────────────
      # DISABLED on both AC and BAT. Turbo boost is the single largest
      # source of thermal spikes, fan spin-ups, and instantaneous power
      # surges. Base clock (3.2 GHz × 6C/12T) is ample for all daily
      # tasks. This alone can reduce peak package power by 15–25 W.
      CPU_BOOST_ON_AC = 0;
      CPU_BOOST_ON_BAT = 0;

      # ── Hardware P-State Dynamic Boost ───────────────────────────────
      # Disabled on both states. Dynamic boost allows firmware to
      # opportunistically spike single-core frequency, generating the
      # same thermal/power surges we're trying to avoid.
      CPU_HWP_DYN_BOOST_ON_AC = 0;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      # ── ACPI Platform Profiles (HP Embedded Controller) ──────────────
      # Controls fan curves, TDP limits, and thermal targets in firmware.
      # AC:  'balanced' — moderate TDP ceiling with conservative fan
      #      curves. Fans stay silent during light loads but will still
      #      ramp dynamically if thermals demand it under sustained work.
      # BAT: 'low-power' — lowest TDP envelope, most conservative fans.
      #      Combined with boost=0 and EPP=power, the CPU rarely reaches
      #      temperatures that trigger fan activity during daily use.
      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # ── AMD Radeon 740M RDNA3 iGPU Power Management ─────────────────
      # DPM 'auto' lets the GPU manage its own power states dynamically.
      # 'low' would cause Hyprland compositor stutter — avoid it.
      # ABM: Adaptive Backlight Management for display power savings.
      #   0 = off (best color accuracy), 2 = moderate (good balance).
      #   Enabled on AC too for consistent low-power behavior.
      AMDGPU_DPM_PERF_LEVEL_ON_AC = "auto";
      AMDGPU_DPM_PERF_LEVEL_ON_BAT = "auto";
      AMDGPU_ABM_LEVEL_ON_AC = 0;
      AMDGPU_ABM_LEVEL_ON_BAT = 2;

      # ── PCIe Active State Power Management (ASPM) ────────────────────
      # 'powersupersave' on BOTH states — enables deepest L1.1/L1.2
      # substates for NVMe, Wi-Fi, and other PCIe devices. Safe because
      # the MT7922 Wi-Fi adapter is excluded from runtime PM separately.
      PCIE_ASPM_ON_AC = "powersupersave";
      PCIE_ASPM_ON_BAT = "powersupersave";

      # ── Runtime PM (PCIe/USB/SoC device suspend) ─────────────────────
      # 'auto' allows idle devices to enter low-power states automatically.
      # The MT7922 Wi-Fi/BT adapter is excluded to prevent connection drops
      # and sleep/wake failures. Verify your PCIe address with: lspci -s 01:00.0
      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";
      RUNTIME_PM_DENYLIST = "01:00.0"; # MediaTek MT7922 Wi-Fi/BT PCIe

      # ── NVMe Power Management (APST) ─────────────────────────────────
      # Autonomous Power State Transitions — saves ~0.5–1 W by allowing
      # the NVMe controller to enter low-power sleep between I/O bursts.
      # Enabled on BOTH states for consistent low-power operation.
      NVM_EXPRESS_PM_ON_AC = 1;
      NVM_EXPRESS_PM_ON_BAT = 1;

      # ── SATA Link Power Management ──────────────────────────────────
      # Device-Initiated PM for the deepest SATA link sleep states.
      # Only effective if SATA devices are present (dock, external drive).
      SATA_LINKPWR_ON_AC = "med_power_with_dipm";
      SATA_LINKPWR_ON_BAT = "med_power_with_dipm";

      # ── Disk I/O Scheduler ───────────────────────────────────────────
      # mq-deadline is optimal for NVMe + Btrfs: low latency, fair queuing.
      DISK_IOSCHED = "mq-deadline";

      # ── Audio Power Saving (AMD ACP / HD Audio) ──────────────────────
      # 1-second timeout before the audio codec enters power saving.
      # Unnoticeable for normal use; saves ~0.3–0.5 W. Enabled on both
      # states for consistent power behavior.
      SOUND_POWER_SAVE_ON_AC = 1;
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";

      # ── Network / Wi-Fi Power Management (MediaTek MT7922) ──────────
      # AC:  'off' — no power saving for maximum reliability at the desk.
      # BAT: 'on' — enables standard 802.11 power saving (PS-Poll/U-APSD).
      #      Saves ~0.3–0.8 W. If you experience latency spikes or 2.4 GHz
      #      coexistence dropouts with Bluetooth, revert to 'off'.
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      # ── USB Autosuspend ──────────────────────────────────────────────
      # Autosuspend idle USB devices after default timeout (2 seconds).
      # Bluetooth host controller is excluded to prevent connection drops
      # and sleep/wake failures with BT peripherals.
      USB_AUTOSUSPEND = 1;
      USB_EXCLUDE_BTUSB = 1; # Prevents BT sleep/wake failures
      USB_DENYLIST = "0e8d:223c"; # MediaTek MT7922 Bluetooth USB

      # ── Peripheral Startup & Battery Power Cut ───────────────────────
      # Enable Wi-Fi and Bluetooth on startup for immediate connectivity.
      # Disable unused radios on battery to save power (NFC/WWAN only —
      # Wi-Fi and Bluetooth are never touched).
      DEVICES_TO_ENABLE_ON_STARTUP = "wifi bluetooth";
      DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "nfc wwan";
    };
  };

  # ── Conflict Prevention ────────────────────────────────────────────
  # power-profiles-daemon and TLP both manage platform profiles and CPU
  # governors. Running both causes profile flapping and unpredictable
  # behavior. Explicitly disable PPD when TLP is active.
  # Also ensure auto-cpufreq and thermald are not enabled elsewhere.
  services.power-profiles-daemon.enable = false;
}
