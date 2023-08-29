{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    nerdfonts
  ];
}
