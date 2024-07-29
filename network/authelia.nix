{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops.defaultSopsFile = ../secrets/authelia.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/styly/.ssh/keys.txt";
  sops.secrets."authelia/jwtSecret" = {owner = "authelia-main";};
  sops.secrets."authelia/sessionKey" = {owner = "authelia-main";};
  sops.secrets."authelia/storageKey" = {
    owner = "authelia-main";
  };
  services.authelia.instances.main = {
    enable = true;
    secrets = {
      jwtSecretFile = /run/secrets/authelia/jwtSecret;
      storageEncryptionKeyFile = /run/secrets/authelia/storageKey;
      sessionSecretFile = /run/secrets/authelia/sessionKey;
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
