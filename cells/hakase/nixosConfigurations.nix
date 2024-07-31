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
      inputs.cells.gpu.nixosProfiles.common-nvidia-gpu
      inputs.cells.bcachefs.nixosModules.bcachefs

      inputs.agenix.nixosModules.default

      inputs.cells.common.nixosProfiles.common-nix
      inputs.cells.common.nixosProfiles.common-packages
      inputs.cells.common.nixosProfiles.common-nixos
      inputs.cells.common.nixosProfiles.common-server
      inputs.cells.common.nixosProfiles.common-home-manager

      inputs.cells.networking.nixosProfiles.proxy

      inputs.cells.nas.nixosProfiles.satoshi
      inputs.cells.nas.nixosProfiles.lab-yyp
      inputs.cells.nas.nixosProfiles.lab-mck

      inputs.cells.virtualisation.nixosProfiles.docker
      inputs.cells.virtualisation.nixosProfiles.podman

      ./configuration.nix
      ./hardware-configuration.nix

      {
        home-manager.users.yousiki = {
          imports = [
          ];
        };
      }
    ];
  };
}
