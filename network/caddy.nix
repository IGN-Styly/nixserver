{
  config,
  lib,
  pkgs,
  ...
}: {
  services.caddy = {
    enable = true;
    virtualHosts."nixos.local".extraConfig = ''
      reverse_proxy http://192.168.122.37:7575
    '';
  };
}
