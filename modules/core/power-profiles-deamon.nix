{profile, ...}: {
  # ┌────────────────────────────────────────────────────────────────┐
  # │  DISABLED — power-profiles-daemon conflicts with TLP.         │
  # │  Both try to manage platform profiles and EPP.                │
  # │  TLP is the sole power manager for this system.               │
  # └────────────────────────────────────────────────────────────────┘
  services.power-profiles-daemon.enable = false;
}