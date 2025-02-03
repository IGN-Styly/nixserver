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
        server = {
            host = "127.0.0.1"; # change to box ip
            port = 9091;
        };
        default_redirection_url = "https://auth.nixie.org";
        theme = "dark";
        default_2fa_method = "totp";
        log.level = "debug";
        #server.disable_healthcheck = true;
        authentication_backend.file.path = "/var/lib/authelia-main/users_database.yml";
        access_control.default_policy = "one_factor";
        session.domain = "nixie.org";
        storage.local.path = "/var/lib/authelia-main/db.sqlite3";
        notifier.filesystem.filename = "/var/lib/authelia-main/notifications.txt";
    };
  };
}
