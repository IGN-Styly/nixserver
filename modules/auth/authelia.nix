{ config, lib, ... }:

let
  authelia = "authelia-nixie";
in
{
  services = {
    authelia.instances.nixie = {
      enable = true;
      settings = {

        theme = "auto";
        authentication_backend.ldap = {
          address = "ldap://localhost:3890";
          base_dn = "dc=nixie,dc=org";
          users_filter = "(&({username_attribute}={input})(objectClass=person))";
          groups_filter = "(member={dn})";
          user = "uid=admin,ou=people,dc=nixie,dc=org";
        };
        access_control = {
          default_policy = "deny";
          # We want this rule to be low priority so it doesn't override the others
          rules = lib.mkAfter [
            {
              domain = "*.nixie.org";
              policy = "one_factor";
            }
          ];
        };
        storage.postgres = {
          address = "unix:///run/postgresql";
          database = authelia;
          username = authelia;
          # I'm using peer authentication, so this doesn't actually matter, but Authelia
          # complains if I don't have it.
          # https://github.com/authelia/authelia/discussions/7646
          password = authelia;
        };
        session = {
          redis.host = "/var/run/redis-nixie/redis.sock";
          cookies = [
            {
              domain = "nixie.org";
              authelia_url = "https://auth.nixie.org";
              # The period of time the user can be inactive for before the session is destroyed
              inactivity = "1M";
              # The period of time before the cookie expires and the session is destroyed
              expiration = "3M";
              # The period of time before the cookie expires and the session is destroyed
              # when the remember me box is checked
              remember_me = "1y";
            }
          ];
        };
        notifier= {
            smtp = {
                  address = "smtp://smtp.sendgrid.net:587";
                  username = "apikey";
                  sender = "admin@nixie.org";
            };
            disable_startup_check=true;
        };
        log.level = "info";
        # identity_providers.oidc = {
        #   cors = {
        #     endpoints = [ "token" ];
        #     allowed_origins_from_client_redirect_uris = true;
        #   };
        #   authorization_policies.default = {
        #     default_policy = "one_factor";
        #     rules = [
        #       {
        #         policy = "deny";
        #         subject = "group:lldap_strict_readonly";
        #       }
        #     ];
        #   };
        # };
        # Necessary for Caddy integration
        # See https://www.authelia.com/integration/proxies/caddy/#implementation
        server.endpoints.authz.forward-auth.implementation = "ForwardAuth";
      };
      # Templates don't work correctly when parsed from Nix, so our OIDC clients are defined here
      #settingsFiles = [ ./oidc_clients.yaml ];
      secrets = with config.sops; {
        jwtSecretFile = secrets."nixie/authelia/jwt_secret".path;
        #oidcIssuerPrivateKeyFile = secrets."nixie/authelia/jwks".path;
        #oidcHmacSecretFile = secrets."nixie/authelia/hmac_secret".path;
        sessionSecretFile = secrets."nixie/authelia/session_secret".path;
        storageEncryptionKeyFile = secrets."nixie/authelia/storage_encryption_key".path;
      };
      environmentVariables = with config.sops; {
        AUTHELIA_AUTHENTICATION_BACKEND_LDAP_PASSWORD_FILE =
          secrets."nixie/authelia/lldap_authelia_password".path;
      };
    };
    caddy = {
      virtualHosts."auth.nixie.org".extraConfig = ''
        tls internal
        reverse_proxy :9091
      '';
      # A Caddy snippet that can be imported to enable Authelia in front of a service
      # Taken from https://www.authelia.com/integration/proxies/caddy/#subdomain
      extraConfig = ''
        (auth) {
            forward_auth :9091 {
                uri /api/authz/forward-auth
                copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
            }
        }
      '';
    };
  };

  # Give Authelia access to the Redis socket
  users.users.${authelia}.extraGroups = [ "redis-nixie" ];

  systemd.services.${authelia} =
    let
      dependencies = [
        "lldap.service"
        "postgresql.service"
        "redis-nixie.service"
      ];

    in
    {
      # Authelia requires LLDAP, PostgreSQL, and Redis to be running
      after = dependencies;
      requires = dependencies;
      # Required for templating
      serviceConfig.Environment = "X_AUTHELIA_CONFIG_FILTERS=template";
    };

  sops.secrets = {
    "nixie/authelia/hmac_secret".owner = authelia;
    "nixie/authelia/jwks".owner = authelia;
    "nixie/authelia/jwt_secret".owner = authelia;
    "nixie/authelia/session_secret".owner = authelia;
    "nixie/authelia/storage_encryption_key".owner = authelia;
    # The password for the `authelia` LLDAP user
    "nixie/authelia/lldap_authelia_password".owner = authelia;

  };


}
