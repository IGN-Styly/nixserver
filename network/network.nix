{pkgs, ...}: {
  imports = [
    ./caddy.nix
    ./homarr.nix
    ./adguard.nix
    ./authelia.nix
  ];
}
