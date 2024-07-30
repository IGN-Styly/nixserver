{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  options = {
    authelia = {
      nodeName = lib.mkOption {
        default = "main";
        description = "The given name for the authelia node by default main.";
        type = lib.types.string;
      };
      autheliaSecrets = {
        owner = concatStrings ["authelia-" config.authelia.nodename];
        sopsFile = lib.mkOption {
          default=../secrets/authelia.yaml
          description="The path to the secret file."
          type=lib.types.path;
        };
        format = lib.mkOption{
            type=lib.types.enum [ "yaml" "json" "binary" "ini" "dotenv" ];
            description="the file type."
            default="yaml"
        };
      };
    };
  };
}
