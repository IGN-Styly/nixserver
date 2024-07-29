{
  config,
  lib,
  pkgs,
  ...
}: {
  services.caddy = {
    enable = true;
    virtualHosts."nix.lab".extraConfig = ''
      reverse_proxy http://192.168.122.37:7575
    '';
  };
}
