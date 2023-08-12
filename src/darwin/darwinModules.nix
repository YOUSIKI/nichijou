{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) haumea;
in
  haumea.lib.load {
    src = ./modules;
    inputs = {inherit inputs cell;};
    transformer = haumea.lib.transformers.liftDefault;
  }
