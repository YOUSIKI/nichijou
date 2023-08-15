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
with builtins // inputs.nixpkgs.lib; {
  home.packages = with pkgs; [
    clang_16
    clang-tools_16
    cmake
    ninja
  ];
}
