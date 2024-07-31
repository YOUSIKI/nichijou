{
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    curl
    direnv
    eza
    fd
    fzf
    git
    home-manager
    htop
    jq
    man
    ripgrep
    tmux
    unzip
    vim
    wget
    zoxide
  ];
}
