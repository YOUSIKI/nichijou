# Common profiles for Nix-darwin.
{
  inputs,
  cell,
}: let
  inherit (inputs.cells.repo.lib) importModules;
in
  importModules ./commonProfiles {
    inherit inputs cell;
  }
