{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  home.packages = with pkgs; [
    clang_16
    clang-tools_16
    cmake
    ninja
  ];
}
