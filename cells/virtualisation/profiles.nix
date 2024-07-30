{
  inputs,
  cell,
}: {
  docker = {
    config,
    pkgs,
    lib,
    ...
  }: {
    virtualisation = {
      docker = {
        enable = true;
        enableOnBoot = true;
        autoPrune.enable = true;
        daemon.settings = {
          ipv6 = true;
          registry-mirrors = ["https://docker.siki.moe"];
        };
      };
    };
    environment.systemPackages = with pkgs; [
      docker-compose
    ];
  };

  podman = {
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
  };
}
