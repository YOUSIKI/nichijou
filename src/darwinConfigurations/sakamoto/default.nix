# Nix-darwin configuration for sakamoto
{globals, ...}: let
  modules = [
    ./_configuration.nix
    globals.outputs.commonProfiles.nix
    globals.outputs.commonProfiles.packages
    globals.outputs.darwinProfiles.base
    globals.outputs.darwinProfiles.desktop.applications
    globals.outputs.darwinProfiles.desktop.fonts
    globals.inputs.home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit globals;};
        users.yousiki = {
          imports = [
            globals.outputs.homeProfiles.base
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
  globals.inputs.darwin.lib.darwinSystem {
    system = "x86_64-darwin";
    specialArgs = {inherit globals;};
    inherit modules;
  }
