{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) importProfiles;
in
  importProfiles {
    src = ./profiles;
    args = {inherit inputs cell;};
  }
