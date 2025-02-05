{pkgs, ...}: {
  imports = [
   # ./deluge.nix
    #./radarr.nix
    #./sonarr.nix
    ./prowlarr.nix
    #./jellyfin.nix
   # ./overseerr.nix
  ];
}
