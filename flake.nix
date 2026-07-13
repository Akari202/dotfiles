{
  description = "Akari202 system flake";

  inputs = {
    nixpkgs-monterey.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin-monterey.url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
    nix-darwin-monterey.inputs.nixpkgs.follows = "nixpkgs-monterey";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin-unstable.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";

    my-nixvim.url = "path:./nixvim";
  };

  outputs =
    inputs@{
      self,
      nix-darwin-monterey,
      nixpkgs-monterey,
      nix-darwin-unstable,
      nixpkgs-unstable,
      ...
    }:

    {
      darwinConfigurations = {
        "thalias" = nix-darwin-monterey.lib.darwinSystem {
          modules = [
            { _module.args.nixpkgs = nixpkgs-monterey; }
            ./modules/common.nix
            ./modules/thalias.nix
          ];
          specialArgs = { inherit inputs self; };
        };
        "samakro" = nix-darwin-unstable.lib.darwinSystem {
          modules = [
            { _module.args.nixpkgs = nixpkgs-unstable; }
            ./modules/common.nix
            ./modules/samakro.nix
          ];
          specialArgs = { inherit inputs self; };
        };
      };
    };
}
