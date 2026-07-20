{
  description = "Akari202 standalone nixvim config";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    # nixvim.url = "github:nix-community/nixvim/nixos-26.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixvim.url = "github:nix-community/nixvim/nixos-24.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    ...
  }: let
    supportedSystems = [
      "x86_64-darwin"
      "aarch64-darwin"
      "x86_64-linux"
      "aarch64-linux"
    ];

    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
  in {
    packages = forAllSystems (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        default = nixvim.legacyPackages.${system}.makeNixvim (
          import ./config.nix {
            inherit pkgs;
            lib = nixpkgs.lib;
            options = {};
            config = {};
          }
        );
      }
    );

    apps = forAllSystems (system: {
      default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/nvim";
      };
    });

    nixosModules.default = {pkgs, ...}: {
      imports = [nixvim.nixosModules.nixvim];
      programs.nixvim = import ./config.nix {
        inherit pkgs;
        lib = nixpkgs.lib;
        options = {};
        config = {};
      };
    };

    darwinModules.default = {pkgs, ...}: {
      imports = [nixvim.nixdarwinModules.nixvim];
      programs.nixvim = import ./config.nix {
        inherit pkgs;
        lib = nixpkgs.lib;
        options = {};
        config = {};
      };
    };
  };
}
