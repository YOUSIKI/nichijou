# Configuration for hakase.
{globals, ...}: let
  nixosModules = with globals.outputs; [
    # Host-specific modules
    ./_configuration.nix
    ./_hardware-configuration.nix

    # Host-specific profiles
    commonProfiles.nix
    commonProfiles.packages
    nixosProfiles.desktop
    nixosProfiles.nvidia-gpu
    nixosProfiles.vscode-server

    # Home-manager module
    globals.inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit globals;};
        users.yousiki = {
          imports = with homeProfiles; [
            base
            lang.complete
            shell
            ssh
          ];
        };
      };
    }
  ];
in
  globals.inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit globals;};
    modules = nixosModules;
  }
