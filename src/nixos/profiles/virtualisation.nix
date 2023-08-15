{
  inputs,
  cell,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // inputs.nixpkgs.lib; {
  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;
}
