{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:{
  environment.systemPackages = [
     pkgs.nss
     pkgs.nssTools
   ];
  services.caddy = {
    dataDir = "/var/lib/caddy";
    enable = true;
    virtualHosts = {
      "nixie.org" = {
        extraConfig = ''
          redir https://dash.nixie.org
          tls internal
        '';
      };
    };
  };
}
