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
  fonts.packages = with pkgs; [
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
