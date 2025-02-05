{
  config,
  lib,
  pkgs,
  ...
}:{
  imports = [./nixserver.nix];
  config.nixserver = {
    email = "claudiotorresptpt@gmail.com";
    displayname = "Styly";
  };
}
