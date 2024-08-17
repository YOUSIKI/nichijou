{
  inputs,
  cell,
}: {
  hakase = {
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
        ];
      };
    };

    imports =
      # Local modules.
      [
        ./nixosProfiles/configuration.nix
        ./nixosProfiles/hardware-configuration.nix
      ]
      # External modules.
      ++ (with inputs; [
        agenix.nixosModules.default
        nixos-hardware.nixosModules.common-cpu-intel-cpu-only
        nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
        nixos-hardware.nixosModules.common-pc-ssd
      ])
      # Internal modules.
      ++ (with inputs.cells; [
        bcachefs.nixosModules.bcachefs
        gpu.nixosProfiles.nvidia
        nas.nixosProfiles.lab-mck
        nas.nixosProfiles.lab-yyp
        nas.nixosProfiles.satoshi
        networking.nixosProfiles.proxy
        nixos.nixosProfiles.common
        virtualisation.nixosProfiles.docker
        virtualisation.nixosProfiles.podman
      ])
      # Home modules.
      ++ [
        {
          home-manager.users.yousiki = {
            imports =
              # External home modules.
              (with inputs; [
                catppuccin.homeManagerModules.catppuccin
              ])
              ++ # Internal home modules.
              (with inputs.cells; [
                home.homeProfiles.common
                languages.homeProfiles.common
              ]);
          };
        }
      ];
  };
}
