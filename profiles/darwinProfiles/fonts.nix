# Install my favorite fonts
{global, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    delugia-code
    nerdfonts
  ];
}