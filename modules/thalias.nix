{pkgs, ...}: {
  imports = [
    ./typst.nix
  ];
  nix.package = pkgs.nixVersions.nix_2_24;
  nixpkgs.hostPlatform = "x86_64-darwin";
  nixpkgs.config.allowDeprecatedx86_64Darwin = true;
  system.stateVersion = 5;
  networking = {
    knownNetworkServices = ["Wi-Fi"];
    hostName = "thalias";
  };
}
