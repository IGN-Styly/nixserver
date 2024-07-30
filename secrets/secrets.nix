{
  pkgs,
  config,
  inputs,
  lib,
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
        jwtSecretFile = {
          description = "path to the jwtsecret file";
          default = "/";
          type = lib.types.path;
        };
        sessionSecretFile = {
          description = "path to the jwtsecret file";
          default = "/";
          type = lib.types.path;
        };
        storageEncryptionKeyFile = {
          description = "path to the jwtsecret file";
          default = "/";
          type = lib.types.path;
        };
      };
    };
  };
  config.secrets.authelia.jwtSecretFile = inputs.sops.nixosModules.sops.secrets."jwtSecret".path;
  config.secrets.authelia.sessionSecretFile = inputs.sops.nixosModules.sops.secrets."sessionKey".path;
  config.secrets.authelia.storageEncryptionKeyFile = inputs.sops.nixosModules.sops.secrets."storageKey".path;
}
