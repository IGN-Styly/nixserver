{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops.age.keyFile = "/root/age/keys.txt";
  sops.secrets."jwtSecret" = config.authelia.autheliaSecrets;
  sops.secrets."sessionKey" = config.authelia.autheliaSecrets;
  sops.secrets."storageKey" = config.authelia.autheliaSecrets;

   options = with config.sops; {
    secrets = {
      authelia = {
        jwtSecretFile = sops.secrets."jwtSecret".path;
        sessionSecretFile = sops.secrets."sessionKey".path;
        storageEncryptionKeyFile = sops.secrets."storageKey".path;
      };
    };
  };
}
