{ sources ? import ./sources.nix }:
let
  overlay = self: pkgs: {
    inherit (import sources.gitignore { inherit (pkgs) lib; })
      gitignoreSource;
  };
in import sources.nixpkgs
  { overlays = [ overlay ] ; config = {}; }
