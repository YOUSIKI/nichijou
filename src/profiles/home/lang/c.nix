# C/C++ configurations.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  home.packages = with pkgs; [
    clang-tools
    cmake
    gcc
    gnumake
    ninja
  ];
}
