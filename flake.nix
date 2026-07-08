{
  description = "Akari202 system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    my-nixvim.url = "path:/Users/ellie/dotfiles/nixvim";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      my-nixvim,
    }:
    let
      systemConfiguration =
        { pkgs, ... }:
        {
          environment.systemPackages = with pkgs; [
            kitty
            neovide
            mpv

            git
            zoxide
            typst
            tree
            ripgrep
            uutils-coreutils
            stow
            zsh-autosuggestions

            my-nixvim.packages.${pkgs.system}.default
          ];

          programs.zsh.enable = true;

          nix.package = pkgs.nixVersions.nix_2_24;
          nix.settings.experimental-features = "nix-command flakes";
          nix.settings.build-users-group = "nixbld";

          nixpkgs.hostPlatform = "x86_64-darwin";
          nixpkgs.config.allowDeprecatedx86_64Darwin = true;

          system.configurationRevision = self.rev or self.dirtyRev or null;
          system.stateVersion = 5;
          system.keyboard = {
            enableKeyMapping = true;
            remapCapsLockToEscape = true;
          };
          system.defaults = {
            dock = {
              autohide = true;
              show-recents = false;
            };
            finder = {
              AppleShowAllExtensions = true;
              FXEnableExtensionChangeWarning = false;
            };
          };
        };
    in
    {
      darwinConfigurations."Thalias" = nix-darwin.lib.darwinSystem {
        modules = [
          systemConfiguration
        ];
      };
    };
}
