{flake, ...}:
flake.inputs.haumea.lib.load {
  src = flake.root + /hosts/nixos;
  inputs = {inherit flake;};
  transformer = [flake.inputs.haumea.lib.transformers.liftDefault];
}
