{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  home.packages = with pkgs; [
    bazel
    clang-tools
    cmake
    gcc
    gnumake
    ninja
  ];
}
