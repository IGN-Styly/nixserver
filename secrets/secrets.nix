{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ../config.nix
  ];
config = {
    sops = {
      templates = {
        "authelia.yaml" = {
          owner = "authelia-main";
          content = ''
            users:
                styly:
                    disabled: false
                    displayname: "${config.nixserver.displayname}"
                    password: "${config.sops.placeholder.autheliaHashedPassword}"
                    email: ${config.nixserver.email}
                    groups:
                        - admin
                        - dev

          '';
        };
        "homarr.env" = {
          mode = "0777";
          content = ''
          AUTH_OIDC_CLIENT_SECRET=${config.sops.placeholder.homarrSecret}
          AUTH_OIDC_CLIENT_ID=${config.sops.placeholder.homarrID}
          '';
        };
      };
      secrets = {
        autheliaHashedPassword = {
          owner="authelia-main";
        };
        jwtSecret = {
          group="keys";
          mode="0777";
        };
        cryptKey = {
          mode="0777";
          group="keys";
        };
        homarrSecret = {
          mode="0777";
          group="keys";
        };
        homarrID = {
          mode="0777";
          group="keys";
        };
        homarrSecretHashed = {
          mode="0777";
          group="keys";
        };
        pKey = {
          owner="authelia-main";
          mode="0777";
          group="keys";
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
