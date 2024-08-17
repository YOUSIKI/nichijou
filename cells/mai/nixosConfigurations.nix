{
  inputs,
  cell,
}: let
in {
  mai = {
    bee = rec {
      system = "x86_64-linux";
      home = inputs.home-manager;
      pkgs = import inputs.nixpkgs-nixos {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [
        ];
      };
    };

    imports = [
      inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
      inputs.nixos-hardware.nixosModules.common-pc-ssd
      inputs.cells.bcachefs.nixosModules.bcachefs

      inputs.agenix.nixosModules.default

      inputs.cells.common.nixosProfiles.common-nix
      inputs.cells.common.nixosProfiles.common-packages
      inputs.cells.common.nixosProfiles.common-nixos
      inputs.cells.common.nixosProfiles.common-desktop
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
            inputs.catppuccin.homeManagerModules.catppuccin
            inputs.cells.home.homeProfiles.common
            inputs.cells.home.homeProfiles.shell
            inputs.cells.home.homeProfiles.wezterm
            inputs.cells.home.homeProfiles.ssh
            inputs.cells.languages.homeProfiles.c
            inputs.cells.languages.homeProfiles.javascript
            inputs.cells.languages.homeProfiles.latex
            inputs.cells.languages.homeProfiles.nix
            inputs.cells.languages.homeProfiles.python
            inputs.cells.languages.homeProfiles.rust
          ];
        };
      }
    ];
  };
}
