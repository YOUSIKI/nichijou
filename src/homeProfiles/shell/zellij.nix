{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
    };
  };
}
