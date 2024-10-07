# Common profiles for NixOS.
{
  inputs,
  cell,
}: let
  inherit (inputs.cells.repo.lib) importModules;
in
  importModules ./commonProfiles {
    inherit inputs cell;
  }
