{...}: {
  flake.nixosModules.common = {flakeInputs, ...}: {
    # Enable podman.
    virtualisation.podman = {
      enable = true;
      autoPrune.enable = true;
      dockerSocket.enable = true;
    };

    # Enable the firewall.
    networking.firewall.enable = true;

    # Configure state version.
    system.stateVersion = "24.05";
  };
}
