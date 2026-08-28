{pkgs, ...}: let
  version = "0.15.1";

  systemMap = {
    "x86_64-darwin" = {
      url = "https://github.com/typst/typst/releases/download/v${version}/typst-x86_64-apple-darwin.tar.xz";
      sha256 = "sha256-f5/dlYSGYkXemnngrdj5I2+ub0CopF4sR3HMwU204Po=";
      dirName = "typst-x86_64-apple-darwin";
    };
  };

  currentSystem = pkgs.stdenv.hostPlatform.system;
  target = systemMap.${currentSystem} or (throw "Unsupported system: ${currentSystem}");

  typst-bin = pkgs.stdenv.mkDerivation {
    pname = "typst";
    inherit version;

    src = pkgs.fetchurl {
      url = target.url;
      sha256 = target.sha256;
    };

    sourceRoot = target.dirName;

    dontBuild = true;
    dontConfigure = true;

    installPhase = ''
      mkdir -p $out/bin
      cp typst $out/bin/typst
      chmod +x $out/bin/typst
    '';
  };
in {
  environment.systemPackages = [typst-bin];
}
