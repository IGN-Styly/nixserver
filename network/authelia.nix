{
  pkgs,
  inputs,
  config,
  ...
}: {
  sops.secrets = {
    "jwtSecret".owner = "authelia-main";
    "sessionKey".owner = "authelia-main";
    "storageKey".owner = "authelia-main";
  };
  services.authelia.instances.main = {
    enable = true;
    secrets = with config.sops; {
      jwtSecretFile = secrets."jwtSecret".path;
      sessionSecretFile = secrets."sessionKey".path;
      storageEncryptionKeyFile = secrets."storageKey".path;
    };

    settings = {
      server.endpoints.authz.forward-auth.implementation = "ForwardAuth";
      theme = "dark";
      default_redirection_url = "https://nixos.lab";

      server = {
        host = "127.0.0.1";
        port = 9091;
      };
    };
  };
}
