{
  inputs,
  self,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Git
    git
    git-lfs
    gnupg

    # Cli tools
    zoxide
    tree
    ripgrep
    uutils-coreutils
    watch
    stow
  ];

  programs.nixvim = {
    enable = true;
    nixpkgs.source = inputs.nixpkgs;
    nixpkgs.overlays = [
      (final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = prev.stdenv.hostPlatform.system;
        };

        rustMonthly = inputs.fenix.packages.${prev.stdenv.hostPlatform.system}.complete.withComponents [
          "cargo"
          "clippy"
          "rustc"
          "rustfmt"
          "rust-src"
        ];

        rustAnalyzerMonthly =
          inputs.fenix.packages.${prev.stdenv.hostPlatform.system}.rust-analyzer;
      })
    ];
    imports = [../../modules/nixvim/module.nix];
  };

  environment.shells = [
    pkgs.zsh
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.build-users-group = "nixbld";
  nix.package = pkgs.nixVersions.latest;

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
