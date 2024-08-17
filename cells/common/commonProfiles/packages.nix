# Basic packages.
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    agenix
    bat
    btop
    curl
    direnv
    eza
    fd
    fzf
    git
    helix
    home-manager
    htop
    jq
    man
    neovim
    rclone
    ripgrep
    rsync
    tmux
    unzip
    vim
    wget
    wget
    zoxide
  ];
}
