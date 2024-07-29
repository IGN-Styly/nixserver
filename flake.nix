{
    description = "NixServer Flake";

    inputs= {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
        # Disko
        disko.url = "github:nix-community/disko";
        disko.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = {self,nixpkgs,disko,...}:
    let
        lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
        nixos = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
        disko.nixosModules.disko
        ./configuration.nix
        ./disko-config.nix
        ./hardware-configuration.nix
        ];
        };
    };
    };
}
