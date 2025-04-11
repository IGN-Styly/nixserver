{
  description = "NixServer Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Disko
    # disko.url = "github:nix-community/disko";
    # disko.inputs.nixpkgs.follows = "nixpkgs";
    #sops
    sops-nix.url = "github:Mic92/sops-nix";
    nixarr.url = "github:rasmus-kirk/nixarr";
  };

  outputs = {
    self,
    nixpkgs,
    sops-nix,
    nixarr,
    ...
  } @inputs: let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          #disko.nixosModules.disko
          nixarr.nixosModules.default
          ./configuration.nix
          #./disko-config.nix
          ./config.nix
          ./hardware-configuration.nix
          inputs.sops-nix.nixosModules.sops
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
