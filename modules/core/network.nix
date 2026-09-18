{
  pkgs,
  host,
  options,
  ...
}:
let
  inherit (import ../../hosts/${host}/variables.nix) hostId;
in
{
  networking = {
    hostName = "${host}";
    hostId = hostId;
    networkmanager.enable = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
      "8.8.4.4"
    ];
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    firewall = {
      enable = true;
      checkReversePath = "loose"; # Required for Tailscale
      trustedInterfaces = [ "tailscale0" ];
      allowedTCPPorts = [
        22
        80
        443
        59010
        59011
        8080
      ];
      allowedUDPPorts = [
        59010
        59011
      ];
    };
  };

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
  systemd.services.NetworkManager-wait-online.enable = false;
}
