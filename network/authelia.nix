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
    group = "keys";
    enable = true;
    settingsFiles = [ ./oidc_clients.yaml ];
    environmentVariables = {"X_AUTHELIA_CONFIG_FILTERS"="template";};
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
        theme = "dark";
        default_2fa_method = "totp";
        log.level = "debug";
        #server.disable_healthcheck = true;
        authentication_backend.file.path = config.sops.templates."authelia.yaml".path;
        storage.local.path = "/var/lib/authelia-main/db.sqlite3";
        notifier.filesystem.filename = "/var/lib/authelia-main/notifications.txt";


        # OIDC


        identity_providers.oidc.hmac_secret = "insecure_oidc_secret";








        access_control = {
          default_policy = "deny";
          networks = [
            {
              name = "internal";
              networks = [
                "127.0.0.1/8"
                "10.89.0.1/24"
                ];
            }
          ];
          rules = [
            {
              domain = "*.nixie.org";
              policy = "bypass";
              networks = [
                "internal"
              ];
            }
            {
              domain = "*.nixie.org";
              policy = "one_factor";
            }
          ];

        };
    };
  };
}
