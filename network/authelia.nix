{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops.defaultSopsFile = ./secrets/authelia.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/styly/.ssh/keys.txt";
  let name = "main";
  let secretName = concatStrings ["authelia-" name];
  sops.secrets."authelia/jwtSecret" = {owner = secretName;};
  sops.secrets."authelia/sessionKey" = {owner = secretName;};
  sops.secrets."authelia/storageKey" = {
    owner = secretName;
  };
  services.authelia.instances.name = {
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
