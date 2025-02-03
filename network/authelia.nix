# To setup user you must manually edit the file /var/lib/authelia-main/users_database.yml
# and to hash the password you can use the following command:
# `authelia crypto hash generate argon2`

{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    authelia
  ];
  services.authelia.instances.main.secrets.jwtSecretFile = config.sops.secrets."jwtSecret".path;
  services.authelia.instances.main.secrets.storageEncryptionKeyFile = config.sops.secrets."cryptKey".path;
  services.authelia.instances.main = {
    enable = true;
    settings = {
      session = {
          secret = "insecure_session_secret";
          name = "authelia_session";
          same_site = "lax";
          inactivity = "5m";
          expiration = "1h";
          remember_me = "1M";
          cookies = [
            {
              domain = "nixie.org";
              authelia_url = "https://auth.nixie.org";
              default_redirection_url = "https://homarr.nixie.org";
              name = "authelia_session";
              same_site = "lax";
              inactivity = "5m";
              expiration = "1h";
              remember_me = "1d";
            }
          ];
        };
        totp.issuer = "authelia.com";
        server = {
          address = "127.0.0.1:9091"; # change to box ip
          endpoints = {
                authz = {
                  forward-auth = {
                    implementation = "ForwardAuth";
                    authn_strategies = [
                      {
                        name = "HeaderAuthorization";
                        schemes = [
                          "Basic"
                        ];
                      }
                      {
                        name = "CookieSession";
                      }
                    ];
                  };
                  ext-authz = {
                    implementation = "ExtAuthz";
                    authn_strategies = [
                      {
                        name = "HeaderAuthorization";
                        schemes = [
                          "Basic"
                        ];
                      }
                      {
                        name = "CookieSession";
                      }
                    ];
                  };
                  auth-request = {
                    implementation = "AuthRequest";
                    authn_strategies = [
                      {
                        name = "HeaderAuthorization";
                        schemes = [
                          "Basic"
                        ];
                      }
                      {
                        name = "CookieSession";
                      }
                    ];
                  };
                  legacy = {
                    implementation = "Legacy";
                    authn_strategies = [
                      {
                        name = "HeaderLegacy";
                      }
                      {
                        name = "CookieSession";
                      }
                    ];
                  };
                };
              };

        };
        default_redirection_url = "https://homarr.nixie.org";
        theme = "dark";
        default_2fa_method = "totp";
        log.level = "debug";
        #server.disable_healthcheck = true;
        authentication_backend.file.path = "/var/lib/authelia-main/users_database.yml";
        session.domain = "nixie.org";
        storage.local.path = "/var/lib/authelia-main/db.sqlite3";
        notifier.filesystem.filename = "/var/lib/authelia-main/notifications.txt";


        access_control = {
          default_policy = "deny";
          rules = [
            {
              domain = "*.nixie.org";
              policy = "one_factor";
            }
          ];
        };
    };
  };
}
