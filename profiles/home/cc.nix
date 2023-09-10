{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  home.packages = with pkgs; [
    cmake
    gcc
    ninja
  ];
}
