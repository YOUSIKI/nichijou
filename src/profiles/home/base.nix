# Basic configurations for Home-manager.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  home.homeDirectory = mkDefault (
    if pkgs.stdenv.isDarwin
    then "/Users/${config.home.username}"
    else "/home/${config.home.username}"
  );

  home.stateVersion = "23.05";
}
