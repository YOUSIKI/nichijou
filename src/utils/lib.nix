{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) haumea;
in
  haumea.lib.load {
    src = ./lib;
    inputs = {inherit inputs cell;};
    transformer = haumea.lib.transformers.liftDefault;
  }
