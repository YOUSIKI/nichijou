{
  globals,
  config,
  self',
  inputs',
  pkgs,
  system,
  ...
}: let
  package = globals.inputs.fenix.packages.${pkgs.system}.complete.toolchain;

  systems = import globals.inputs.default-systems;
in
  if builtins.elem system systems
  then package
  else null
