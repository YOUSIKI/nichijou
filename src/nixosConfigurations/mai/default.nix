{globals, ...}: let
  modules = [
    ./_configuration.nix
    ./_hardware-configuration.nix
    globals.outputs.commonProfiles.nix
    globals.outputs.commonProfiles.packages
    globals.outputs.nixosProfiles.desktop.applications
    globals.outputs.nixosProfiles.desktop.fonts
    globals.outputs.nixosProfiles.misc.base
    globals.outputs.nixosProfiles.misc.virtualisation
  ];
in
  globals.inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit globals;};
    inherit modules;
  }
