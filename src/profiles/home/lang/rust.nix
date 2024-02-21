# Rust configurations.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  home.packages = with pkgs; [
    fenix.stable.toolchain
  ];
}
