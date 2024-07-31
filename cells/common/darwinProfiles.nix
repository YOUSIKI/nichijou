{
  inputs,
  cell,
}: {
  # Basic nix configuration for both NixOS and Darwin.
  common-nix = import ./common-nix.nix;

  # Basic packages for both NixOS and Darwin.
  common-packages = import ./common-packages.nix;

  # Basic configuration for home-manager
  common-home-manager = import ./common-home-manager.nix;
}
