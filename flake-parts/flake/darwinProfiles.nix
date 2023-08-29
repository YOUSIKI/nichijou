{flake, ...}:
flake.inputs.haumea.lib.load {
  src = flake.root + /profiles/darwin;
  inputs = {inherit flake;};
}
