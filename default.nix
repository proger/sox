let
  pkgs = import ./nix {};
in (pkgs.callPackage ./nix/sox.nix {
  inherit (pkgs.darwin.apple_sdk.frameworks) CoreAudio;
}).overrideDerivation (old: {
  src = pkgs.gitignoreSource ./.;
})
