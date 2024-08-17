{inputs, ...}: {
  imports = [
    inputs.cells.common.darwinProfiles.nix
    inputs.cells.common.darwinProfiles.packages
    inputs.cells.common.darwinProfiles.home-manager
  ];
}
