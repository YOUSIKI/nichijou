{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  editor =
    if config.programs.neovim.enable
    then "nvim"
    else if config.programs.helix.enable
    then "hx"
    else if config.programs.vim.enable
    then "vim"
    else "nano";
in {
  nixpkgs = {
    inherit (globals.nixpkgs) overlays;
  };

  home.homeDirectory =
    if hasSuffix "-darwin" pkgs.system
    then "/Users/${config.home.username}"
    else "/home/${config.home.username}";

  home.sessionVariables = {
    EDITOR = mkDefault editor;
    VISUAL = mkDefault editor;
  };

  home.stateVersion = "23.05";
}
