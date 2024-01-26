{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  environment.systemPackages = with pkgs; [
    curl
    duf
    eza
    gh
    git
    helix
    tmux
    vim
    wget
  ];

  programs.fish.enable = true;
  programs.zsh.enable = true;

}
