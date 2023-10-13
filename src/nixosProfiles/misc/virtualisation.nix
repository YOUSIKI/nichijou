{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  virtualisation = {
    docker.enable = true;
    podman.enable = true;
    lxc.enable = true;
    lxd.enable = true;
    kvmgt.enable = true;
  };
}
