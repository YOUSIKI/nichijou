{flake, ...}:
flake.inputs.haumea.lib.load {
  src = flake.root + /profiles/nixos;
  inputs = {inherit flake;};
}
