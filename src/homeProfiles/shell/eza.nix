{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  programs.eza = {
    enable = true;
    enableAliases = true;
    icons = true;
    git = true;
  };
}
