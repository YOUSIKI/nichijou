# Default package which joins all packages in the flake.
# `nix build --print-out-paths | cachix push nichijou` will cache all packages.
{
  self',
  pkgs,
  ...
}:
pkgs.symlinkJoin {
  name = "nichijou-packages";
  paths =
    pkgs.lib.attrValues
    (pkgs.lib.filterAttrs
      (n: v: n != "default" && pkgs.lib.isDerivation v)
      self'.packages);
}
