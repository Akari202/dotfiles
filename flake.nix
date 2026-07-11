{
  description = "Akari202 system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin-unstable.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin-unstable.inputs.nixpkgs.follows = "nixpkgs-unstable";

    my-nixvim.url = "path:/Users/ellie/dotfiles/nixvim";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-darwin-unstable,
      nixpkgs-unstable,
      my-nixvim,
    }:
    let
      sharedConfiguration =
        { pkgs, ... }:
        {
          environment.systemPackages = with pkgs; [
            kitty
            neovide
            mpv
            # firefox

            git
            gnupg
            pinentry_mac
            zoxide
            typst
            tree
            ripgrep
            uutils-coreutils
            stow
            zsh-autosuggestions
            darwin.trash

            my-nixvim.packages.${pkgs.system}.default
          ];

          programs.zsh.enable = true;
          environment.shells = [ pkgs.zsh ];

          nix.settings.experimental-features = "nix-command flakes";
          nix.settings.build-users-group = "nixbld";
          system.configurationRevision = self.rev or self.dirtyRev or null;

          nix.gc = {
            automatic = true;
            interval = [
              {
                Hour = 3;
                Minute = 15;
                Weekday = 7;
              }
            ];
          };
          nix.optimise = {
            automatic = true;
            interval = [
              {
                Hour = 4;
                Minute = 15;
                Weekday = 7;
              }
            ];
          };
          power = {
            sleep = {
              computer = 15;
              display = 5;
            };
          };

          networking = {
            knownNetworkServices = [ "Wi-Fi" ];
            computerName = "¯\\_(ツ)_/¯";
            dns = [
              "1.1.1.1"
              "1.0.0.1"
              "2606:4700:4700::1111"
              "2606:4700:4700::1001"
            ];
          };
          system.keyboard = {
            enableKeyMapping = true;
            remapCapsLockToEscape = true;
          };
          system.defaults = {
            NSGlobalDomain = {
              AppleShowAllFiles = true;
              "com.apple.swipescrolldirection" = false;
            };
            dock = {
              autohide = true;
              show-recents = false;
              tilesize = 52;
            };
            controlcenter = {
              BatteryShowPercentage = true;
            };
            finder = {
              AppleShowAllExtensions = true;
              AppleShowAllFiles = true;
              CreateDesktop = false;
              FXEnableExtensionChangeWarning = false;
              ShowPathbar = false;
            };
            loginwindow = {
              LoginwindowText = "We're Here Because";
              SHOWFULLNAME = true;
            };
            menuExtraClock = {
              Show24Hour = true;
              ShowDayOfMonth = true;
              ShowDayOfWeek = true;
              ShowSeconds = false;
              ShowDate = 0;
            };
            trackpad = {
              Clicking = true;
              ActuationStrength = 1;
              FirstClickThreshold = 0;
              SecondClickThreshold = 0;
              TrackpadRightClick = true;
            };
          };
        };

      intelHardwareConfig =
        { pkgs, ... }:
        {
          environment.systemPackages = [
            my-nixvim.packages.${pkgs.system}.default
          ];

          nix.package = pkgs.nixVersions.nix_2_24;
          nixpkgs.hostPlatform = "x86_64-darwin";
          nixpkgs.config.allowDeprecatedx86_64Darwin = true;
          system.stateVersion = 5;
          networking = {
            knownNetworkServices = [ "Wi-Fi" ];
            hostName = "thalias";
          };
        };

      appleSiliconHardwareConfig =
        { pkgs, ... }:
        {
          environment.systemPackages = [
            my-nixvim.packages.${pkgs.system}.unstable
          ];
          nix.package = pkgs.nixVersions.latest;
          system.stateVersion = 7;
          networking = {
            # knownNetworkServices = [ "Wi-Fi" ];
            hostName = "samakro";
          };

          nixpkgs.hostPlatform = "aarch64-darwin";

          security.pam.services.sudo_local = {
            enable = true;
            touchIdAuth = true;
            watchIdAuth = false;
          };
          system.defaults = {
            trackpad = {
              ForceSuppressed = false;
              TrackpadThreeFingerVertSwipeGesture = 2;
              ActuateDetents = true;
              TrackpadThreeFingerHorizSwipeGesture = 2;
            };
          };
        };

    in
    # run-nix-darwin-rebuild-tasks = pkgs.writeShellScriptBin "run-nix-darwin-rebuild-tasks" ''
    #   set -e
    #   echo "Entered nix environment"
    #   : "''${STOW_LOG_FILE:=stow.log}"
    #
    #   echo "Running gnu stow"
    #   ${pkgs.stow}/bin/stow . 2>&1 | tee -a "$STOW_LOG_FILE"
    #
    #   echo "Formatting nix files"
    #   ${pkgs.nixfmt-rfc-style}/bin/nixfmt **/*.nix
    # '';
    {
      darwinConfigurations = {
        "thalias" = nix-darwin.lib.darwinSystem {
          modules = [
            sharedConfiguration
            intelHardwareConfig
          ];
        };

        "samakro" = nix-darwin-unstable.lib.darwinSystem {
          modules = [
            sharedConfiguration
            appleSiliconHardwareConfig
          ];
        };
      };

      # apps.${system}.default = {
      #   type = "app";
      #   program = "${run-nix-darwin-rebuild-tasks}/bin/run-nix-darwin-rebuild-tasks";
      # };
    };
}
