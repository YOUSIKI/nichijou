{
  inputs,
  cell,
}: {...}: {
  imports = [
    inputs.cells.common.commonProfiles.core
  ];

  # Enable podman.
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerSocket.enable = true;
  };

  system.stateVersion = "24.05";
}
