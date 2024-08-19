# Podman and podman-compose.
{
  config,
  pkgs,
  lib,
  ...
}: let
  dockerEnabled = config.virtualisation.docker.enable;
  nvidiaEnabled = config.hardware.nvidia-container-toolkit.enable;
in {
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = !dockerEnabled;
    dockerSocket.enable = !dockerEnabled;
  };
  environment.systemPackages = with pkgs; (
    [
      docker-compose # required by podman-compose
      podman-compose
    ]
    ++ lib.optionals nvidiaEnabled [
      nvidia-podman
    ]
  );
}
