{ config, pkgs, ... }:

{
  networking.firewall.enable = true;

  # Enable IP forwarding (needed for VPN)
  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.nat.externalInterface = "eth0";  # Change to your real interface

  # WireGuard server config
  networking.wireguard.interfaces = {
    wg0 = {
      # Listen port for WireGuard
      listenPort = 51820;

      # Your private key (keep it secret!)
      privateKeyFile = "/etc/wireguard/private.key";

      # IP address for this server in VPN network
      ips = [ "10.100.0.1/24" ];

      # Allowed peers
      peers = [
        {
          publicKey = "di5r5DQCMJ7Q1KPI1rmxZgpawD4e0nkpqXglhizEo1s=";
          allowedIPs = [ "10.100.0.2/32" ];  # Each client gets one IP
        }
        # Add more peers as needed
      ];
    };
  };

  # Enable firewall port for WireGuard
  networking.firewall.allowedUDPPorts = [ 51820 ];
}
