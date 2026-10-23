{
  description = "Akar202 standalone Nixvim configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
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
        config.allowUnfree = true;
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
