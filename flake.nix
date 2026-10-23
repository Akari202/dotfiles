{
  description = "Akari202 system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    nixpkgs-unstable,
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
              unstable = import nixpkgs-unstable {
                system = prev.stdenv.hostPlatform.system;
                config.allowUnfree = true;
              };
            })
          ];
        })
      ];
    };
    # nixosConfigurations."roscu" = nixpkgs.lib.nixosSystem {
    #   system = "aarch64-linux";
    #   specialArgs = {inherit inputs self;};
    #
    #   modules = [
    #     ./hosts/roscu/hardware-configuration.nix
    #     ./hosts/roscu/configuration.nix
    #
    #     ({pkgs, ...}: {
    #       nixpkgs.overlays = [
    #         (final: prev: {
    #           unstable = import nixpkgs-unstable {
    #             system = prev.stdenv.hostPlatform.system;
    #             config.allowUnfree = true;
    #           };
    #         })
    #       ];
    #     })
    #   ];
    # };
  };
}
