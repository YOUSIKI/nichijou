{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) haumea;
in
  if builtins.pathExists ./hosts
  then
    haumea.lib.load {
      src = ./hosts;
      inputs = {inherit inputs cell;};
      transformer = haumea.lib.transformers.liftDefault;
    }
  else {}
