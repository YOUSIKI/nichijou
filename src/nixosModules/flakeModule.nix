{...} @ args: {
  flake.nixosModules = {
    common = import ./common.nix args;
    desktop = import ./desktop.nix args;
    nvidia = import ./nvidia.nix args;
    server = import ./server.nix args;
  };
}
