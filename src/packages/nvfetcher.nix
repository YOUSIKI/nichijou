{
  globals,
  config,
  self',
  inputs',
  pkgs,
  system,
  ...
}:
if pkgs.lib.hasAttr system globals.inputs.nvfetcher.packages
then globals.inputs.nvfetcher.packages.${system}.default
else null
