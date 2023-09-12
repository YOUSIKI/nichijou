{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;
  virtualisation.lxc = {
    enable = false;
    lxcfs.enable = true;
  };
  virtualisation.lxd = {
    enable = false;
    recommendedSysctlSettings = true;
  };
}
