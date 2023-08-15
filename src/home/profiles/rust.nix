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
    fenix.complete.toolchain
  ];
}
