{
  inputs,
  cell,
}: let
  inherit (inputs.cells.repo.lib) importModule;
in {
  # Basic nix configuration for both NixOS and Darwin.
  common-nix = importModule ./common-nix.nix;

  # Basic packages for both NixOS and Darwin.
  common-packages = importModule ./common-packages.nix;

  # Basic configuration for home-manager
  common-home-manager = importModule ./common-home-manager.nix;
}
