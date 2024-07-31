{
  inputs,
  cell,
}: {
  # Configure docker on NixOS
  docker = import ./docker.nix;

  # Configure podman on NixOS
  podman = import ./podman.nix;
}
