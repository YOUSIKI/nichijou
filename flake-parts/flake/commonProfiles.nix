# Profiles shared by NixOS and Nix-darwin
{flake, ...}:
flake.inputs.haumea.lib.load {
  src = flake.root + /profiles/common;
  inputs = {inherit flake;};
}
