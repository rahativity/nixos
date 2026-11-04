{
  pkgs,
  host,
  options,
  ...
}: let
  inherit (import ../../hosts/${host}/variables.nix) hostId;
in {
  networking = {
    hostName = "${host}";
    hostId = hostId;
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        # 22    # SSH
        # 80    # HTTP
        # 443   # HTTPS
        # 59010 # Local file transfer
        # 59011 # Local file transfer
        # 8080  # Web dev server
      ];
      allowedUDPPorts = [
        # 59010 # Local file transfer
        # 59011 # Local file transfer
      ];
    };
  };

  environment.systemPackages = with pkgs; [networkmanagerapplet];
  systemd.services.NetworkManager-wait-online.enable = false;
}
