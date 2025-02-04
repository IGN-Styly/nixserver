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
          sopsFile = ./secrets.yaml;
          owner = ''authelia-main'';
        };
        cryptKey = {
            sopsFile = ./secrets.yaml;
            owner = ''authelia-main'';
        };
        oidcSecret = {
            sopsFile = ./secrets.yaml;
            owner = ''homarr'';
        };
        oidcKey = {
            sopsFile = ./secrets.yaml;
            owner = ''authelia-main'';
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
