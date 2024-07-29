{
  inputs,
  cell,
}: {
  # Basic nix configuration for both NixOS and Darwin.
  common-nix = {
    config,
    pkgs,
    lib,
    ...
  }: {
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
        inherit (inputs.self.nixConfig) substituters trusted-substituters trusted-public-keys;
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
        lib.mapAttrs
        (n: v: {flake = v;})
        (lib.removeAttrs inputs ["nixpkgs" "cells" "self"]);
    };
  };

  # Basic packages for both NixOS and Darwin.
  common-packages = {
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
  };
}
