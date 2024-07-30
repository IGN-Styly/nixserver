{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];
  sops.defaultSopsFile = ../secrets/authelia.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/styly/.ssh/keys.txt";
  sops.secrets."jwtSecret" = {owner = "authelia-main";};
  sops.secrets."sessionKey" = {owner = "authelia-main";};
  sops.secrets."storageKey" = {
    owner = "authelia-main";
  };
  services.authelia.instances.main = {
    enable = true;
    secrets = with config.sops; {
                    jwtSecretFile = secrets."jwtSecret".path;
                    sessionSecretFile = secrets."sessionKey".path;
                    storageEncryptionKeyFile = secrets."storageKey".path;
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
