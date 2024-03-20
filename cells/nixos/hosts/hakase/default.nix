{
  inputs,
  cell,
}: {
  _module.specialArgs = {
    inherit inputs;
  };

  imports = [
    ./configuration.nix
    ./hardware-configuration.nix

    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
    inputs.nixos-hardware.nixosModules.common-pc-hdd
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    inputs.cells.common.commonProfiles.core

    inputs.cells.nixos.nixosProfiles.core
  ];

  bee = rec {
    system = "x86_64-linux";
    home = inputs.home-manager;
    pkgs = import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        cudaSupport = true;
      };
      overlays = [];
    };
  };
}
