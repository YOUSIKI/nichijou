# Basic packages.
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    agenix
    bat
    bottom
    broot
    btop
    colmena
    comma
    curl
    direnv
    duf
    dust
    eza
    fastfetch
    fd
    fzf
    git
    helix
    home-manager
    htop
    jq
    macchina
    man
    neofetch
    neovim
    nerdfetch
    ouch
    procs
    rclone
    ripgrep
    rsync
    skim
    tealdeer
    tmux
    tokei
    unzip
    vim
    wget
    wget
    xcp
    zellij
    zoxide
    zstd
  ];

  programs.zsh.enable = true; # Don't delete this line on nix-darwin!
}
