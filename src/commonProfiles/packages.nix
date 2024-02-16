# Basic packages for NixOS and Nix-darwin.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  environment.systemPackages = with pkgs; [
    alejandra
    curl
    duf
    eza
    fd
    fzf
    gdu
    gh
    git
    helix
    home-manager
    htop
    jq
    man
    neofetch
    nvfetcher
    ripgrep
    rsync
    vim
    wget
    zellij
  ];

  programs.fish.enable = true;
  programs.tmux.enable = true;
  programs.zsh.enable = true;
}
