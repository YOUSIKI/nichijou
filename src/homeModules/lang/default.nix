{...} @ args: {
  c = import ./c.nix args;
  latex = import ./latex.nix args;
  nix = import ./nix.nix args;
  python = import ./python.nix args;
  rust = import ./rust.nix args;
}
