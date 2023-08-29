{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;
}
