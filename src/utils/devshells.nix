{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) std;
  inherit (inputs.nixpkgs) lib;

  devshells = lib.mapAttrs (name: std.lib.dev.mkShell) {
    default = {
      pkgs,
      extraModulesPath,
      ...
    }: {
      name = "develop";

      imports = [
        std.std.devshellProfiles.default
      ];

      packages = with pkgs; [
        helix
        home-manager
        neovim
        nvfetcher
        vim
      ];

      commands = [];

      nixago = [];
    };
  };
in
  devshells
