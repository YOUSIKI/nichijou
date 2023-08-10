{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) std;
  inherit (inputs.nixpkgs-lib.lib) mapAttrs;

  devshells = mapAttrs (_: std.lib.dev.mkShell) {
    default = {
      extraModulesPath,
      pkgs,
      ...
    }: {
      name = "develop";

      imports = [
        std.std.devshellProfiles.default
      ];

      packages = with pkgs; [
        helix
      ];

      commands = [];

      nixago = [];
    };
  };
in
  devshells
