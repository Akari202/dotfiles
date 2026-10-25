{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.nixvim.nixosModules.nixvim
    inputs.nixos-raspberrypi.nixosModules.raspberry-pi-4.base
    ../common/configuration.nix
    ./hardware-configuration.nix
  ];

  sops = {
    secrets.akari-password.neededForUsers = true;
    defaultSopsFile = ./secrets.yaml;
  };

  networking = {
    hostName = "roscu";
    useDHCP = true;
  };

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "prohibit-password";
  };

  time.timeZone = "America/New_York";
  users.users = {
    akari = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.akari-password.path;
      extraGroups = ["wheel"];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ710+tXhA6lsHu44h2zhN7zgl7iFJavGjxnulXVakd0 akaritwo0two@gmail.com"
      ];
    };
    root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ710+tXhA6lsHu44h2zhN7zgl7iFJavGjxnulXVakd0 akaritwo0two@gmail.com"
    ];
  };

  system.stateVersion = "26.05";
}
