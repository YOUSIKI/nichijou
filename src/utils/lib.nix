{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) haumea;
in
  if builtins.pathExists ./lib
  then
    haumea.lib.load {
      src = ./lib;
      inputs = {inherit inputs cell;};
      transformer = haumea.lib.transformers.liftDefault;
    }
  else {}
