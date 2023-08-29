{flake, ...}:
flake.inputs.haumea.lib.load {
  src = flake.root + /hosts/darwin;
  inputs = {inherit flake;};
  transformer = [flake.inputs.haumea.lib.transformers.liftDefault];
}
