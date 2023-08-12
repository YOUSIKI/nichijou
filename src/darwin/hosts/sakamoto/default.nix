{
  inputs,
  cell,
  ...
}: let
  system = "x86_64-darwin";
in {
  bee.system = system;
  bee.home = inputs.home-manager;
  bee.darwin = inputs.darwin;
  bee.pkgs = import inputs.nixpkgs {
    inherit system;

    config.allowUnfree = true;
    config.allowBroken = false;
    config.allowUnsupportedSystem = false;
    config.permittedInsecurePackages = [];

    overlays = [];
  };

  imports = [
    cell.darwinProfiles.base
    cell.darwinProfiles.fonts
    cell.darwinProfiles.homebrew
  ];
}
