{
  inputs,
  cell,
}: let
  inherit (inputs.cells.common.lib) importPackages;
in
  importPackages {
    src = ./packages;
  }
