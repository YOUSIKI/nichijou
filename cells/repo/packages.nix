{
  inputs,
  cell,
}: let
  inherit (inputs.cells.repo.lib) collectPackages;
in
  collectPackages "${inputs.self}/packages"
