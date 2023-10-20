{
  globals,
  config,
  self',
  inputs',
  pkgs,
  system,
  ...
}: let
  package = globals.inputs.fh.packages.${pkgs.system}.default;

  systems = import globals.inputs.default-systems;
in
  if builtins.elem system systems
  then package
  else null
