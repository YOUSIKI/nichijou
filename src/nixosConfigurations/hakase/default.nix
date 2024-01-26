{globals, ...}: let
  modules = [
    ./_configuration.nix
    ./_hardware-configuration.nix
    globals.outputs.commonProfiles.nix
    globals.outputs.commonProfiles.packages
    globals.outputs.nixosProfiles.base
    globals.outputs.nixosProfiles.nvidia-gpu
    globals.outputs.nixosProfiles.vscode-server
    globals.inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit globals;};
        users.yousiki = {
          imports = [
            globals.outputs.homeProfiles.base
            globals.outputs.homeProfiles.secrets
          ];
        };
      };
    }
  ];
in
  globals.inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit globals;};
    inherit modules;
  }
