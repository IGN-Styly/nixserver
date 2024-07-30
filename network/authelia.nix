{
  pkgs,
  inputs,
  config,
  ...
}: {
  services.authelia.instances.main = {
    server.endpoints.authz.forward-auth.implementation = "ForwardAuth";
    enable = true;
    secrets = {
      jwtSecretFile = config.secrets.authelia.jwtSecretFile;
      sessionSecretFile = config.secrets.authelia.sessionSecretFile;
      storageEncryptionKeyFile = config.secrets.authelia.storageEncryptionKeyFile;
    };

    settings = {
      theme = "dark";
      default_redirection_url = "https://nixos.lab";

      server = {
        host = "127.0.0.1";
        port = 9091;
      };
    };
  };
}
