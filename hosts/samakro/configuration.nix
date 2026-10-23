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
    # unstable.qbittorrent

    # Cli tools
    pinentry_mac
    darwin.trash
    unstable.typst
    unstable.devenv
    sops

    # Installed outside of Nix:
    # keepassxc
    # mullvad-vpn
    # kicad
    # bambu-studio
    # Raspberry Pi Imager

    # Installed from app store
    # Affinity Designer

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
    inputs.nixvim.nixDarwinModules.nixvim
    ../common/configuration.nix
    ./settings.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 7;
}
