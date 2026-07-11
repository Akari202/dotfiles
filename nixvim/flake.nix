{
  description = "Akari202 standalone nixvim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nixvim.url = "github:nix-community/nixvim/nixos-24.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixvim-unstable.url = "github:nix-community/nixvim";
    nixvim-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixvim,
      nixpkgs-unstable,
      nixvim-unstable,
      ...
    }@inputs:
    let

      supportedSystems = [
        "x86_64-darwin"
        "aarch64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {

      packages = forAllSystems (
        system:
        let
          pkgsStable = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          nixvimPackagesStable = nixvim.legacyPackages.${system};

          hasUnstableSystem = nixpkgs.lib.hasAttr system nixvim-unstable.legacyPackages;

          pkgsUnstable =
            if hasUnstableSystem then
              import nixpkgs-unstable {
                inherit system;
                config.allowUnfree = true;
              }
            else
              null;

          nixvimPackagesUnstable =
            if hasUnstableSystem then nixvim-unstable.legacyPackages.${system} else null;
        in
        {
          default = nixvimPackagesStable.makeNixvimWithModule {
            pkgs = pkgsStable;
            module = import ./config.nix;
          };
        }
        // nixpkgs.lib.optionalAttrs hasUnstableSystem {
          unstable = nixvimPackagesUnstable.makeNixvimWithModule {
            pkgs = pkgsUnstable;
            module = import ./config.nix;
          };
        }
      );
    };
}
