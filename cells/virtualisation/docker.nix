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
    };
  };
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
