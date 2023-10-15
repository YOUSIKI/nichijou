{globals, ...}: let
  modules = [
    ./_configuration.nix
    ./_hardware-configuration.nix
    globals.outputs.commonProfiles.nix
    globals.outputs.commonProfiles.packages
    globals.outputs.nixosProfiles.base
    globals.outputs.nixosProfiles.desktop.applications
    globals.outputs.nixosProfiles.desktop.fonts
    globals.outputs.nixosProfiles.desktop.hyprland
    globals.outputs.nixosProfiles.virtualisation
    globals.inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit globals;};
        users.yousiki = {
          imports = [
            globals.outputs.homeProfiles.base
            globals.outputs.homeProfiles.desktop.hyprland
            globals.outputs.homeProfiles.desktop.kitty
            globals.outputs.homeProfiles.lang.c
            globals.outputs.homeProfiles.lang.latex
            globals.outputs.homeProfiles.lang.nix
            globals.outputs.homeProfiles.lang.python
            globals.outputs.homeProfiles.lang.rust
            globals.outputs.homeProfiles.shell.combined
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
