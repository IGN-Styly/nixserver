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
    # globalConfig = ''

    #   pki {
    #     ca home {
    #         name "My Home CA"
    #     }
    #   }

    # '';
    virtualHosts = {
      "nixie.org" = {
        extraConfig = ''
          redir https://homarr.nixie.org
          tls internal
        '';
      };
    };
  };
}
