{
  config,
  inputs,
  lib,
  ...
}: {

config = {
    sops = {
      secrets = {
        jwtSecret = {
          owner = ''authelia-main'';
        };
        cryptKey = {
            owner = ''authelia-main'';
        };
        homarrSecret = {
            owner = ''homarr'';
        };
        homarrID = {
            owner = ''homarr'';
        };
        homarrSecretHashed = {
            owner = ''homarr'';
        };

      };
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
      age = {
        # This is the default AGE key that will be used for bootstrapping the system
        keyFile = "/home/styly/.config/sops/age/keys.txt";
        # This will automatically import SSH host keys as AGE keys
        # sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      };
    };
  };
}
