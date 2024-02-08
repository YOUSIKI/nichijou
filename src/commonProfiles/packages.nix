# Basic packages for NixOS and Nix-darwin.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  environment.systemPackages = with pkgs; [
    bat
    bottom
    btop
    curl
    duf
    eza
    fzf
    gdu
    gh
    helix
    jq
    man
    neofetch
    ripgrep
    vim
    wget
    zellij
  ];

  programs.fish.enable = true;
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.tmux.enable = true;
  programs.zsh.enable = true;
}
