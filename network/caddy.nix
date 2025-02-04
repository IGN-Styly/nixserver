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
      "homarr.nixie.org" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:7575
         	tls internal
          forward_auth 127.0.0.1:9091 {
                          uri /api/authz/forward-auth
                          ## The following commented line is for configuring the Authelia URL in the proxy. We strongly suggest
                          ## this is configured in the Session Cookies section of the Authelia configuration.
                          # uri /api/authz/forward-auth?authelia_url=https://auth.example.com/
                          copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
                  }
          '';
      };
      "adguard.nixie.org" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:3000
         	tls internal
          forward_auth 127.0.0.1:9091 {
                          uri /api/authz/forward-auth
                          ## The following commented line is for configuring the Authelia URL in the proxy. We strongly suggest
                          ## this is configured in the Session Cookies section of the Authelia configuration.
                          # uri /api/authz/forward-auth?authelia_url=https://auth.example.com/
                          copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
                  }
          '';
      };
      "auth.nixie.org" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:9091
         	tls internal
        '';
      };
    };
  };
}
