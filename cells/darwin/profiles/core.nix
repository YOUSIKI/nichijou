{
  inputs,
  cell,
}: {...}: {
  imports = [
    inputs.cells.common.commonProfiles.core
  ];

  services.activate-system.enable = true;
  services.nix-daemon.enable = true;

  environment.systemPackages = [
    cell.packages.lporg
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
