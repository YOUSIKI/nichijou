{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  fonts.packages = with pkgs; [
    delugia-code
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    noto-fonts-lgc-plus
    twemoji-color-font
  ];
}
