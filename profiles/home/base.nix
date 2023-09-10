{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  home.homeDirectory =
    if hasSuffix "-darwin" pkgs.system
    then "/Users/${config.home.username}"
    else "/home/${config.home.username}";

  home.stateVersion = "23.05";

  nixpkgs.overlays = [
    flake.inputs.emacs-overlay.overlays.default
    flake.inputs.fenix.overlays.default
    flake.inputs.nvfetcher.overlays.default
    flake.outputs.overlays.default
  ];
}
