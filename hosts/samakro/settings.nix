{
  inputs,
  self,
  pkgs,
  ...
}: {
  # defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
  # defaults write com.apple.desktopservices DSDontWriteUSBStores -bool TRUE

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
