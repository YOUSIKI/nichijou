{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) haumea;
in
  haumea.lib.load {
    src = ./hosts;
    inputs = {inherit inputs cell;};
    transformer = haumea.lib.transformers.liftDefault;
  }
