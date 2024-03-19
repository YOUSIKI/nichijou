{...} @ args: {
  flake.nixosConfigurations = {
    hakase = import ./hakase/default.nix args;
  };
}
