{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    extensions = with pkgs; [
      gh-actions-cache
      gh-cal
      gh-dash
      gh-eco
      gh-markdown-preview
    ];
  };
}
