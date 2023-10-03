{global, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  imports = [
    ./_catppuccin_modules/bat.nix
    ./_catppuccin_modules/bottom.nix
    ./_catppuccin_modules/btop.nix
    ./_catppuccin_modules/gitui.nix
    ./_catppuccin_modules/starship.nix
  ];
}
