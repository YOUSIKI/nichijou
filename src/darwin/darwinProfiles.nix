{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) haumea;
in
  if builtins.pathExists ./profiles
  then
    haumea.lib.load {
      src = ./profiles;
      inputs = {inherit inputs cell;};
      transformer = haumea.lib.transformers.liftDefault;
    }
  else {}
