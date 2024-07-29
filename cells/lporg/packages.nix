{
  inputs,
  cell,
}: let
  inherit (inputs.cells.repo.lib) callPackageWithSources;
  inherit (inputs) nixpkgs;
in {
  lporg = callPackageWithSources nixpkgs ./recipe.nix;
}
