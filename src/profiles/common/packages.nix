# Basic packages for NixOS and Nix-darwin.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  environment.systemPackages = with pkgs // globals.outputs.packages.${pkgs.system};
    [
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
      nodejs
      nvfetcher
      ripgrep
      rsync
      vim
      wget
      zellij
    ]
    ++ (optionals pkgs.stdenv.isDarwin [lporg]);

  programs.fish.enable = true;
  programs.tmux.enable = true;
  programs.zsh.enable = true;
}
