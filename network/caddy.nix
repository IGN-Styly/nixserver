{
  config,
  lib,
  pkgs,
  ...
}: {
  services.caddy = {
    enable = true;
    virtualHosts."nixos.lab".extraConfig = ''
      reverse_proxy http://192.168.122.37:7575
      tls internal
    '';
  };
}
