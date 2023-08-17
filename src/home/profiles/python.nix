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
with builtins // inputs.nixpkgs.lib; let
  packages = with pkgs; [
    black
    isort
    poetry
    python311Full
    ruff
    ruff-lsp
  ];

  linuxPackages = [
    inputs.cells.common.packages.conda
  ];
in {
  home.packages =
    packages
    ++ (
      if pkgs.system == "x86_64-linux"
      then linuxPackages
      else []
    );
}
