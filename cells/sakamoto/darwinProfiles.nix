# Local profiles for sakamoto.
{
  inputs,
  cell,
}: let
  inherit (inputs.cells.repo.lib) importModules;
in
  importModules ./darwinProfiles {
    inherit inputs cell;
  }
