{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };
}
