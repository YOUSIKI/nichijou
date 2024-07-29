{
  inputs,
  cell,
}: let
  inherit (inputs.cells.repo.functions) collectPackages;
in
  collectPackages "${inputs.self}/packages"
