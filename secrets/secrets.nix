{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [<sops-nix/modules/sops>];
  sops.age.keyFile = "/root/age/keys.txt";
  sops.secrets."jwtSecret" = config.authelia.autheliaSecrets;
  sops.secrets."sessionKey" = config.authelia.autheliaSecrets;
  sops.secrets."storageKey" = config.authelia.autheliaSecrets;

  options = {
    secrets = {
      authelia = {
        jwtSecretFile = sops.secrets."jwtSecret".path;
        sessionSecretFile = sops.secrets."sessionKey".path;
        storageEncryptionKeyFile = sops.secrets."storageKey".path;
      };
    };
  };
}
