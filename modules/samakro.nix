{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    firefox
    calibre
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
}
