# Configuration for sakamoto, which is an intel MacbookPro.
{globals, ...}: let
  darwinModules = [
    # Host-specific modules
    ./_configuration.nix

    # Host specific profiles
    globals.outputs.commonProfiles.nix
    globals.outputs.commonProfiles.packages
  ];
in
  globals.inputs.darwin.lib.darwinSystem {
    system = "x86_64-darwin";
    specialArgs = {inherit globals;};
    modules = darwinModules;
  }
