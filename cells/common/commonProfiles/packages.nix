# Basic packages.
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    agenix
    aria2
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
    gdu
    git
    helix
    home-manager
    htop
    jq
    macchina
    man
    neofetch
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
    wget
    wget
    xcp
    zellij
    zoxide
    zstd
  ];

  programs.zsh.enable = true; # Don't delete this line on nix-darwin!
}
