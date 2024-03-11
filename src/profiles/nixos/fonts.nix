# Basic packages for NixOS and Nix-darwin.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  fontPackages = with pkgs; [
    lxgw-neoxihei
    lxgw-wenkai
    nerdfonts
    noto-fonts-cjk
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    source-han-mono
    source-han-sans
    source-han-serif
    wqy_microhei
    wqy_zenhei
  ];
in {
  fonts.fontDir.enable = true;
  fonts.packages = fontPackages;
}
