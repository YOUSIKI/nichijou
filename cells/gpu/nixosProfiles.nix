# GPU-related NixOS profiles
{
  inputs,
  cell,
}: let
  inherit (inputs.cells.repo.lib) importModules;
in
  importModules ./nixosProfiles {
    inherit inputs cell;
  }
