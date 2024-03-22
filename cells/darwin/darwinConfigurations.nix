{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) importConfigurations;
in
  importConfigurations {
    src = ./hosts;
    args = {inherit inputs cell;};
  }
