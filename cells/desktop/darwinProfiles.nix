# Nix-darwin profiles for desktop.
{
  inputs,
  cell,
}: let
  inherit (inputs.cells.repo.lib) importModules;
in
  importModules ./darwinProfiles {
    inherit inputs cell;
  }
