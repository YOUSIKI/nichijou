{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  nixpkgs = {
    inherit (globals.nixpkgs) overlays;
  };

  home.homeDirectory =
    if hasSuffix "-darwin" pkgs.system
    then "/Users/${config.home.username}"
    else "/home/${config.home.username}";

  home.stateVersion = "23.05";
}
