{
  config,
  pkgs,
  lib,
  ...
}: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = !config.virtualisation.docker.enable;
    autoPrune.enable = true;
    dockerSocket.enable = !config.virtualisation.docker.enable;
  };
  environment.systemPackages = with pkgs; [
    docker-compose
    podman-compose
  ];
}
