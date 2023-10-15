{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    tmux.enableShellIntegration = true;
  };
}
