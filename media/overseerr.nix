{
  config,
  lib,
  pkgs,
  ...
}: {
  services.jellyseerr.enable = true;
  environment.systemPackages = [
      pkgs.jellyfin
      pkgs.jellyfin-web
      pkgs.jellyfin-ffmpeg
    ];
}
