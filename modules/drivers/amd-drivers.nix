{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.drivers.amdgpu;
in {
  options.drivers.amdgpu = {
    enable = mkEnableOption "Enable AMD Drivers";
  };

  config = mkIf cfg.enable {
    boot.kernelParams = ["amdgpu.abmlevel=0"];
    systemd.tmpfiles.rules = ["L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"];
    services.xserver.videoDrivers = ["amdgpu"];
  };
}
