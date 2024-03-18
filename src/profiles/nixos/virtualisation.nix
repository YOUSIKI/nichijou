# Configure virutalisation for NixOS.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
    daemon.settings = {
      experimental = true;
      ip6tables = true;
    };
  };

  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
  };
}
