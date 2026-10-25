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
    # freecad
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

  programs.nixvim = {
    akari.rust.toolchain.enable = true;
    akari.rust.analyzer.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 7;
  nix.settings.trusted-users = ["root" "akari"];

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
}
