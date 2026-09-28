{
  inputs,
  self,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Graphical applications
    unstable.kitty
    mpv
    firefox-bin
    (prismlauncher.override {
      jdks = [
        zulu25
      ];
    })
    unstable.qbittorrent

    # Git
    git
    git-lfs
    gnupg
    pinentry_mac

    # Cli tools
    zoxide
    tree
    sops
    ripgrep
    uutils-coreutils
    zsh-autosuggestions
    darwin.trash
    unstable.typst
    unstable.devenv

    # Neovim
    inputs.my-nixvim.packages.${pkgs.system}.default

    # Installed outside of Nix:
    # keepassxc
    # mullvad-vpn
    # kicad
    # bambu-studio

    # Not installed
    # ghidra-bin
    # matlab
    # nerd-fonts.symbols-only
    # (octave.withPackages (octavePkgs:
    #   with octavePkgs; [
    #     symbolic
    #   ]))
  ];

  imports = [
  ];

  environment.shells = [
    pkgs.zsh
  ];

  # defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
  # defaults write com.apple.desktopservices DSDontWriteUSBStores -bool TRUE

  programs.zsh.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.build-users-group = "nixbld";
  nix.package = pkgs.nixVersions.latest;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 7;

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
    knownNetworkServices = ["Wi-Fi" "Thunderbolt Bridge"];
    computerName = "Samakro";
    hostName = "samakro";
    dns = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
  };
  system.primaryUser = "akari";
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
  system.defaults = {
    NSGlobalDomain = {
      AppleShowAllFiles = true;
      AppleICUForce24HourTime = true;
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
      ShowPathbar = true;
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
      ForceSuppressed = false;
      TrackpadThreeFingerVertSwipeGesture = 2;
      ActuateDetents = true;
      TrackpadThreeFingerHorizSwipeGesture = 2;
    };
  };

  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
    watchIdAuth = false;
  };
}
