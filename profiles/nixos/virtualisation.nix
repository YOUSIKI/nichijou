{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;
  virtualisation.lxd.enable = true;
  virtualisation.lxc.enable = true;
}
