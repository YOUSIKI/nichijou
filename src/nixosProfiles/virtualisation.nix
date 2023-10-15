{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  virtualisation = {
    docker.enable = true;
    podman.enable = true;
  };
}
