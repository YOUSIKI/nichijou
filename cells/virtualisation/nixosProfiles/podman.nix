# Podman and podman-compose.
{
  config,
  pkgs,
  ...
}: let
  dockerEnabled = config.virtualisation.docker.enable;
in {
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = !dockerEnabled;
    dockerSocket.enable = !dockerEnabled;
  };
  environment.systemPackages = with pkgs; [
    docker-compose # required by podman-compose
    podman-compose
  ];
}
