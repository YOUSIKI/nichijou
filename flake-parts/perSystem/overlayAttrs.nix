{
  config,
  self',
  inputs',
  pkgs,
  system,
  flake,
  ...
}:
import ./packages.nix {
  inherit config self' inputs' pkgs system flake;
}
