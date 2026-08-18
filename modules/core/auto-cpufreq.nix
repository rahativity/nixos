{
  pkgs,
  ...
}: {
  # ┌────────────────────────────────────────────────────────────────┐
  # │  DISABLED — auto-cpufreq conflicts with TLP on amd-pstate-epp │
  # │  auto-cpufreq sets 'performance' governor which locks EPP     │
  # │  and defeats hardware-driven autonomous frequency scaling.    │
  # │  TLP is the sole power manager for this system.               │
  # └────────────────────────────────────────────────────────────────┘
  services.auto-cpufreq.enable = false;
}
