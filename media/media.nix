{pkgs, ...}: {
  imports = [
    ./deluge.nix
    ./radarr.nix
    ./sonarr.nix
    ./jackett.nix
    ./jellyfin.nix
    ./overseerr.nix
  ];
}
