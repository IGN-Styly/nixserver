{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:{
  # ...
  services.caddy = {
    enable = true;
    virtualHosts = {
      "auth.nixie.org" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:9091
        '';
      };
    };
  };
}
