{pkgs, ...}: {
  imports = [
    ./caddy.nix
    ./homarr.nix
    ./adguard.nix
  ];
}
