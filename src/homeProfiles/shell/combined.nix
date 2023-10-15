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
    nvfetcher
    nvim
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
      gdu
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
    ++ (optionals pkgs.stdenv.isLinux (with pkgs; [
      cloudflare-warp
      nitch
    ]));

  home.sessionPath = [
    "/usr/local/bin"
  ];
}
