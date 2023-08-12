{
  inputs,
  cell,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // inputs.nixpkgs.lib; {
  bee.home = inputs.home-manager;
  bee.darwin = inputs.darwin;
  bee.pkgs = import inputs.nixpkgs {
    system = config.bee.system;

    config.allowUnfree = true;
    config.allowBroken = false;
    config.allowUnsupportedSystem = false;
    config.permittedInsecurePackages = [];

    overlays = [];
  };

  home.homeDirectory =
    if hasSuffix "-darwin" pkgs.system
    then "/Users/${config.home.username}"
    else "/home/${config.home.username}";

  home.stateVersion = "23.05";
}
