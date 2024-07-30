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
          default = inputs.sops.nixosModules.sops.secrets."jwtSecret".path;
          type = lib.types.path;
        };
        sessionSecretFile = {
          description = "path to the jwtsecret file";
          default = inputs.sops.nixosModules.sops.secrets."sessionKey".path;
          type = lib.types.path;
        };

        storageEncryptionKeyFile = {
          description = "path to the jwtsecret file";
          default = inputs.sops.nixosModules.sops.secrets."storageKey".path;
          type = lib.types.path;
        };
      };
    };
  };
}
