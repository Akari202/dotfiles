{pkgs, ...}: let
  colemak-dh-bundle = pkgs.stdenvNoCC.mkDerivation {
    pname = "colemak-dh-macOS";
    version = "1.0.0";

    src = pkgs.fetchFromGitHub {
      owner = "ColemakMods";
      repo = "mod-dh";
      rev = "master";
      hash = "sha256-w5RZmD5GmakIvpNd9xbYfkXtpjnMHwSQssNU9/m1bb8=";
    };

    dontBuild = true;
    dontConfigure = true;

    installPhase = ''
      mkdir -p $out/Library/Keyboard\ Layouts
      cp -r macOS/*.bundle $out/Library/Keyboard\ Layouts/
    '';
  };
in {
  environment.systemPackages = [colemak-dh-bundle];

  system.activationScripts.postActivation.text = ''
    echo "setting up Colemak keyboard layouts..."
    mkdir -p "/Library/Keyboard Layouts"
    for bundle in ${colemak-dh-bundle}/Library/Keyboard\ Layouts/*.bundle; do
      if [ -e "$bundle" ]; then
        target="/Library/Keyboard Layouts/$(basename "$bundle")"
        rm -rf "$target"
        ln -s "$bundle" "$target"
      fi
    done
  '';
}
