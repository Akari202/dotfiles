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
            # firefox

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
            hostName = "thalias";
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
              # LoginwindowText = "";
              SHOWFULLNAME = true;
            };
            menuExtraClock = {
              Show24Hour = true;
              ShowDayOfMonth = true;
              ShowDayOfWeek = true;
              ShowSeconds = false;
              ShowDate = 0;
            };
            # trackpad = {
            #   ActuateDetents = true;
            #   Clicking = true;
            #   ActuationStrength = 1;
            #   FirstClickThreshold = 0;
            #   SecondClickThreshold = 0;
            #   TrackpadRightClick = true;
            #   TrackpadThreeFingerHorizSwipeGesture = 2;
            #   TrackpadThreeFingerVertSwipeGesture = 2;
            #   ForceSuppressed = false;
            # };
          };
          # security.pam.services.sudo_local = {
          #     enable = true;
          #     touchIdAuth = true;
          #     watchIdAuth = false;
          # };
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
