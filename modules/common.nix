{
  inputs,
  self,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    kitty
    neovide
    mpv

    git
    git-lfs
    inputs.my-nixvim.packages.${pkgs.system}.default
    gnupg
    pinentry_mac
    zoxide
    tree
    sops
    ripgrep
    uutils-coreutils
    zsh-autosuggestions
    darwin.trash
    keepassxc
    # devenv
  ];

  programs.zsh.enable = true;
  environment.shells = [pkgs.zsh];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
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
    knownNetworkServices = ["Wi-Fi"];
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
}
