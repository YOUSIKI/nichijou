# Python configurations.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  minicondaPath = "~/.miniconda";
in {
  home.packages = with pkgs; [
    black
    isort
    poetry
    python3
    ruff
    ruff-lsp
    yapf
  ];
}
