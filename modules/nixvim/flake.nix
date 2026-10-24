{
  description = "Akar202 standalone Nixvim configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    fenix.url = "github:nix-community/fenix/monthly";
    fenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixvim,
    ...
  }: let
    supportedSystems = [
      "aarch64-darwin"
      "x86_64-linux"
      "aarch64-linux"
    ];

    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);

    mkNvim = system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            unstable = import inputs.nixpkgs-unstable {
              system = prev.stdenv.hostPlatform.system;
            };

            rustMonthly = inputs.fenix.packages.${prev.stdenv.hostPlatform.system}.complete.withComponents [
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
      };
    in
      nixvim.legacyPackages.${system}.makeNixvimWithModule {
        inherit pkgs;
        module = import ./module.nix;
      };
  in {
    packages = forAllSystems (system: {
      default = mkNvim system;
    });

    apps = forAllSystems (system: {
      default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/nvim";
      };
    });
  };
}
