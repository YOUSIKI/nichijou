{
  inputs,
  cell,
}: let
in {
  hakase = {
    bee = rec {
      system = "x86_64-linux";
      home = inputs.home-manager;
      pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          cudaSupport = true;
        };
        overlays = [
        ];
      };
    };

    imports = [
      inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
      inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
      inputs.nixos-hardware.nixosModules.common-pc-ssd
      inputs.cells.gpu.profiles.common-nvidia-gpu
      inputs.cells.bcachefs.modules.bcachefs

      inputs.agenix.nixosModules.default

      inputs.cells.common.profiles.common-nix
      inputs.cells.common.profiles.common-packages
      inputs.cells.common.profiles.common-nixos
      inputs.cells.common.profiles.common-server

      inputs.cells.networking.profiles.proxy

      inputs.cells.nas.profiles.satoshi
      inputs.cells.nas.profiles.lab-yyp
      inputs.cells.nas.profiles.lab-mck

      inputs.cells.virtualisation.profiles.docker
      inputs.cells.virtualisation.profiles.podman

      ./configuration.nix
      ./hardware-configuration.nix
    ];
  };
}
