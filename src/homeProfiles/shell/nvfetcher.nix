{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = [
    globals.outputs.packages.${pkgs.system}.nvfetcher
  ];
}
