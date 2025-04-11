{
  config,
  lib,
  pkgs,
  ...
}: {
  services.deluge.enable = true;
  services.deluge.web.enable = true;
  services.deluge.authFile=config.sops.templates."deluge".path;
}
