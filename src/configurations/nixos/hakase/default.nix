# Configuration for hakase.
{globals, ...}:
globals.inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = {inherit globals;};
  modules =
    [
      ./_configuration.nix
      ./_hardware-configuration.nix

      globals.inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {inherit globals;};
          users.yousiki = {
            imports = with globals.outputs.homeProfiles; [
              base
              lang.complete
              shell
              ssh
            ];
          };
        };
      }
    ]
    ++ (with globals.inputs.nixos-hardware.nixosModules; [
      common-cpu-intel-cpu-only
      common-gpu-nvidia-nonprime
      common-pc-hdd
      common-pc-ssd
    ])
    ++ (with globals.outputs.commonProfiles; [
      nix
      packages
    ])
    ++ (with globals.outputs.nixosProfiles; [
      desktop
      nas
      nvidia-gpu
      sops
      vscode-server
    ]);
}
