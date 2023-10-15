{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = [
    globals.inputs.nvfetcher.packages.${pkgs.system}.default
  ];
}
