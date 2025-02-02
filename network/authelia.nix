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
  services.authelia.main.secrets.jwtSecretFile = config.sops.secrets."jwtSecret".path;
  services.authelia.main.secrets.storageEncryptionKeyFile = config.sops.secrets."cryptKey".path;
  services.authelia.instances.main = {
    enable = true;

  };
}
