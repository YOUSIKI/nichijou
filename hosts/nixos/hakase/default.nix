# NixOS configuration for hakase
{flake, ...}:
flake.inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = {inherit flake;};
  modules = [
    ./_configuration.nix
    ./_hardware-configuration.nix

    flake.outputs.nixosProfiles.base
    flake.outputs.nixosProfiles.applications
    flake.outputs.nixosProfiles.fonts
    flake.outputs.nixosProfiles.nvidia
    flake.outputs.nixosProfiles.virtualisation
    flake.outputs.nixosProfiles.vscode-server

    flake.inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {inherit flake;};
      home-manager.users.yousiki = {
        imports = [
          flake.outputs.homeProfiles.base
          flake.outputs.homeProfiles.cc
          flake.outputs.homeProfiles.python
          flake.outputs.homeProfiles.rust
          flake.outputs.homeProfiles.shell
        ];
      };
    }
  ];
}
