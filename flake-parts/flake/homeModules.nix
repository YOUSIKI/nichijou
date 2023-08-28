{flake, ...}:
flake.inputs.haumea.lib.load {
  src = flake.root + /modules/home;
  inputs = {inherit flake;};
}
