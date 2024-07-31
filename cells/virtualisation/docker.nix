{
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
}
