{
  inputs,
  cell,
}: {
  pkgs,
  lib,
  ...
}: let
  l = builtins // lib;

  flake = import "${inputs.self}/flake.nix";
in {
  # Basic nix configuration for both NixOS and Darwin.
  nix = {
    settings = {
      # Nix automatically detects files in the store that have identical contents, and replaces them with hard links to a single copy.
      auto-optimise-store = true;
      # Nix will instruct remote build machines to use their own binary substitutes if available.
      builders-use-substitutes = true;
      # Experimental nix features.
      experimental-features = ["flakes" "nix-command"];
      # Nix will fall back to building from source if a binary substitute fails.
      fallback = true;
      # The garbage collector will keep the derivations from which non-garbage store paths were built.
      keep-derivations = true;
      # The garbage collector will keep the outputs of non-garbage derivations.
      keep-outputs = true;
      # Builds will be performed in a sandboxed environment on Linux.
      sandbox = pkgs.stdenv.isLinux;
      # These users will have additional rights when connecting to the Nix daemon.
      trusted-users = ["root" "@wheel" "@admin"];
      # Never warn about dirty Git/Mercurial trees.
      warn-dirty = false;
      # Substituters and public keys.
      inherit (flake.nixConfig) substituters trusted-substituters trusted-public-keys;
    };

    # Garbage collector
    gc.automatic = true;

    # List of directories to be searched for <...> file references.
    nixPath = [
      "nixpkgs=flake:nixpkgs"
      "darwin=/etc/nix/inputs/darwin"
      "home-manager=flake:home-manager"
    ];

    registry =
      l.mapAttrs
      (n: v: {flake = v;})
      (l.removeAttrs inputs ["nixpkgs" "cells" "self"]);
  };

  # Basic packages for both NixOS and Darwin.
  environment.systemPackages = with pkgs; [
    agenix
    alejandra
    cachix
    cloudflared
    colmena
    comma
    curl
    direnv
    du-dust
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
    mc
    neofetch
    nodejs
    nvfetcher
    ouch
    rclone
    ripgrep
    rsync
    statix
    thefuck
    tmux
    vim
    wget
    yazi
    zellij
    zoxide
  ];

  programs.fish.enable = true;
  programs.zsh.enable = true;
}
