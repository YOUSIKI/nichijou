{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  # Nixpkgs configuration
  inherit (globals) nixpkgs;

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
      # Builds will be performed in a sandboxed environment.
      sandbox = false;
      # These users will have additional rights when connecting to the Nix daemon.
      trusted-users = ["root" "@wheel" "@admin"];
      # Never warn about dirty Git/Mercurial trees.
      warn-dirty = false;
      # Trusted substituters
      trusted-substituters = [
        "https://cache.garnix.io"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://numtide.cachix.org"
      ];
      # Trusted public keysW
      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
    };

    # Garbage collector
    gc.automatic = true;

    # List of directories to be searched for <...> file references.W
    nixPath = [
      "darwin=/etc/nix/inputs/darwin"
      "home-manager=flake:home-manager"
      "nixpkgs=flake:nixpkgs"
    ];

    registry =
      mapAttrs
      (n: v: {flake = v;})
      (removeAttrs globals.inputs ["nixpkgs"]);
  };
}
