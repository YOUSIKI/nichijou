# Configuration for sakamoto, which is an intel MacbookPro.
{globals, ...}: let
  darwinModules = with globals.outputs; [
    # Host-specific modules
    ./_configuration.nix

    # Host specific profiles
    commonProfiles.nix
    commonProfiles.packages
    darwinProfiles.applications

    # Home-manager module
    globals.inputs.home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {inherit globals;};
        users.yousiki = {
          imports = [
            globals.outputs.homeProfiles.base
          ];
        };
      };
    }
  ];
in
  globals.inputs.darwin.lib.darwinSystem {
    system = "x86_64-darwin";
    specialArgs = {inherit globals;};
    modules = darwinModules;
  }
