{
  description = "Akari202 system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    fenix.url = "github:nix-community/fenix/monthly";
    fenix.inputs.nixpkgs.follows = "nixpkgs";

    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/nixos-26.05";
    nixos-raspberrypi.inputs.nixpkgs.follows = "nixpkgs";
    nixos-raspberrypi.inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    ...
  }: {
    darwinConfigurations."samakro" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {inherit inputs self;};
      modules = [
        ./hosts/samakro/configuration.nix

        ({pkgs, ...}: {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import inputs.nixpkgs-unstable {
                system = prev.stdenv.hostPlatform.system;
              };

              rustMonthly = inputs.fenix.packages.${prev.stdenv.hostPlatform.system}.minimal.withComponents [
                "cargo"
                "clippy"
                "rustc"
                "rustfmt"
                "rust-src"
              ];

              rustAnalyzerMonthly =
                inputs.fenix.packages.${prev.stdenv.hostPlatform.system}.rust-analyzer;
            })
          ];
        })
      ];
    };
    nixosConfigurations."roscu" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = {inherit inputs self;};

      modules = [
        ./hosts/roscu/configuration.nix

        ({pkgs, ...}: {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import inputs.nixpkgs-unstable {
                system = prev.stdenv.hostPlatform.system;
              };
              rustMonthly = inputs.fenix.packages.${prev.stdenv.hostPlatform.system}.minimal.withComponents [
                "cargo"
                "clippy"
                "rustc"
                "rustfmt"
                "rust-src"
              ];

              rustAnalyzerMonthly =
                inputs.fenix.packages.${prev.stdenv.hostPlatform.system}.rust-analyzer;
            })
          ];
        })
      ];
    };
  };
}
