{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    clang-tools
    cmake
    gcc
    gnumake
    ninja
  ];
}
