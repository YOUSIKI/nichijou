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

    inputs.cells.nixos.nixosModules.bcachefs
    inputs.cells.nixos.nixosModules.qbittorrent

    inputs.cells.nixos.nixosProfiles.core
    inputs.cells.nixos.nixosProfiles.desktop
    inputs.cells.nixos.nixosProfiles.nvidia
    inputs.cells.nixos.nixosProfiles.ollama
    inputs.cells.nixos.nixosProfiles.proxy
    inputs.cells.nixos.nixosProfiles.secrets
    inputs.cells.nixos.nixosProfiles.server

    inputs.cells.home.homeProfiles.base

    {
      home-manager.users.yousiki = {
        imports = [
          inputs.catppuccin.homeManagerModules.catppuccin

          inputs.cells.home.homeProfiles.core
          inputs.cells.home.homeProfiles.languages
          inputs.cells.home.homeProfiles.shell
          inputs.cells.home.homeProfiles.ssh
        ];

        bee.home-languages = [
          "c"
          "latex"
          "nix"
          "node"
          "python"
          "rust"
        ];
      };
    }
  ];

  bee = rec {
    system = "x86_64-linux";
    home = inputs.home-manager;
    pkgs = import inputs.nixpkgs-nixos {
      inherit system;
      config = {
        allowUnfree = true;
        cudaSupport = true;
      };
      overlays = [
        inputs.agenix.overlays.default
        inputs.colmena.overlays.default
        inputs.fenix.overlays.default
        inputs.nvfetcher.overlays.default
      ];
    };
  };
}
