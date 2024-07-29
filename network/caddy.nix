{
  config,
  lib,
  pkgs,
  ...
}: {
  services.caddy = {
    enable = true;
    virtualHosts."nixos.lab".extraConfig = ''
      forward_auth 192.168.122.37:9091 {
        uri /api/verify?rd=auth.nixos.lab
        copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
      }
      tls internal
      reverse_proxy http://192.168.122.37:7575
        tls internal
    '';
    virtualHosts."auth.nixos.lab".extraConfig = ''
      reverse_proxy http://192.168.122.37:9091
      tls internal
    '';
    virtualHosts."adguard.nixos.lab".extraConfig = ''
      forward_auth 192.168.122.37:9091 {
        uri /api/verify?rd=auth.nixos.lab
        copy_headers Remote-User Remote-Groups Remote-Name Remote-Email
      }
      tls internal
      reverse_proxy http://192.168.122.37:3000
    '';
  };
}
