{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  imports = with globals.outputs.homeProfiles.shell; [
    bash
    bat
    bottom
    btop
    eza
    fzf
    gh
    git
    gitui
    helix
    mcfly
    nix-index
    starship
    tmux
    zoxide
    zsh
  ];

  programs.htop.enable = true;
  programs.jq.enable = true;
  programs.lazygit.enable = true;
  programs.ripgrep.enable = true;
  programs.vim.enable = true;

  home.packages =
    (with pkgs; [
      _1password
      cachix
      clash
      code-minimap
      curl
      du-dust
      duf
      fd
      home-manager
      mc
      mosh
      neofetch
      nettools
      nodejs
      rclone
      rsync
      statix
      thefuck
      unzip
      wget
      zip
    ])
    ++ (optional pkgs.stdenv.isLinux (with pkgs; [
      busybox
      cloudflare-warp
      nitch
    ]));

  home.sessionPath = [
    "/usr/local/bin"
  ];
}
