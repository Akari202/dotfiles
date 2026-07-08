{
  description = "Akari202 standalone nixvim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nixvim.url = "github:nix-community/nixvim/nixos-24.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixvim,
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
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          nixvimPackages = nixvim.legacyPackages.${system};

          nixvimModule = {
            inherit pkgs;
            module = import ./config.nix;
          };
        in
        {
          default = nixvimPackages.makeNixvimWithModule nixvimModule;
        }
      );
    };
}
