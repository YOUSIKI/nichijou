# Home-manager profiles
{flake, ...}:
flake.inputs.haumea.lib.load {
  src = flake.root + /profiles/home;
  inputs = {inherit flake;};
}
