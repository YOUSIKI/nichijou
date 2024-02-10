# Nix configurations.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  home.packages = with pkgs; [
    alejandra
    nil
    rnix-lsp
    deadnix
  ];
}
