{
  config,
  lib,
  pkgs,
  ...
}:{
  options.nixserver = {
    email = lib.mkOption {
      default = "example@example.com";
      type = lib.types.str;
      description = "Email to use for the nixserver, mainly authelia.";
    };
    displayname = lib.mkOption {
      default = "Example User";
      type = lib.types.str;
      description = "The display name to use for the nixserver, mainly authelia.";
    };
  };
}
