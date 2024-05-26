{
  inputs,
  cell,
}: {
  config,
  pkgs,
  lib,
  ...
}: let
  l = builtins // lib;
in {
  home.homeDirectory = l.mkDefault (
    if pkgs.stdenv.isDarwin
    then "/Users/${config.home.username}"
    else "/home/${config.home.username}"
  );

  xdg.enable = true;

  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  home.stateVersion = "23.05";
}
