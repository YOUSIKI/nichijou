{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) haumea;
in
  if builtins.pathExists ./modules
  then
    haumea.lib.load {
      src = ./modules;
      inputs = {inherit inputs cell;};
      transformer = haumea.lib.transformers.liftDefault;
    }
  else {}
