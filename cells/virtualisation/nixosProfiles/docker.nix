# Docker and docker-compose.
{pkgs, ...}: {
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true; # Start docker on boot.
      autoPrune.enable = true; # Enable automatic pruning of unused containers.
    };
  };
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
