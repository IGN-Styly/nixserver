{
  config,
  lib,
  ...
}:

let
  cfg = config.services.lldap;
in
{
  services = {
    lldap = {
      enable = true;
      settings = {
        ldap_base_dn = "dc=nixie,dc=cc";
        ldap_user_email = "admin@nixie.org";
        database_url = "postgresql://lldap@localhost/lldap?host=/run/postgresql";
      };
      environment = {
        LLDAP_JWT_SECRET_FILE = config.sops.secrets."nixie/lldap/jwt_secret".path;
        LLDAP_KEY_SEED_FILE = config.sops.secrets."nixie/lldap/key_seed".path;
        LLDAP_LDAP_USER_PASS_FILE = config.sops.secrets."nixie/lldap/admin_password".path;
      };
    };
    caddy.virtualHosts."users.nixie.org".extraConfig = ''
      reverse_proxy :${toString cfg.settings.http_port}
    '';
  };

  systemd.services.lldap =
    let
      dependencies = [
        "postgresql.service"
      ];
    in
    {
      # LLDAP requires PostgreSQL to be running
      after = dependencies;
      requires = dependencies;
      # DynamicUser screws up sops-nix ownership because
      # the user doesn't exist outside of runtime.
      serviceConfig.DynamicUser = lib.mkForce false;
    };

  # Setup a user and group for LLDAP
  users = {
    users.lldap = {
      group = "lldap";
      isSystemUser = true;
    };
    groups.lldap = { };
  };

  sops.secrets = {
    "nixie/lldap/jwt_secret".owner = "lldap";
    "nixie/lldap/key_seed".owner = "lldap";
    "nixie/lldap/admin_password".owner = "lldap";
  };
}
