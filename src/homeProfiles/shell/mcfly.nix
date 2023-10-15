{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  programs.mcfly = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    fuzzySearchFactor = 3;
  };
}
