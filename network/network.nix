{pkgs, ...}: {
  imports = [
    ./authelia.nix
    ./homarr.nix
    ./caddy.nix
    ./adguard.nix
    ./vaultwarden.nix
  ];
}
