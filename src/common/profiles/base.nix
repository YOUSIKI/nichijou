{
  inputs,
  cell,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // inputs.nixpkgs.lib; {
  bee.home = inputs.home-manager;
  bee.darwin = inputs.darwin;
  bee.pkgs = import inputs.nixpkgs {
    system = config.bee.system;

    config.allowUnfree = true;
    config.allowBroken = false;
    config.allowUnsupportedSystem = false;
    config.permittedInsecurePackages = [];

    overlays = [];
  };

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
      sandbox = true;
      # These users will have additional rights when connecting to the Nix daemon.
      trusted-users = ["root" "@wheel" "@admin"];
      # Trusted substituters
      trusted-substituters = [
        "https://cache.garnix.io"
        "https://cachix.org/api/v1/cache/emacs"
        "https://colmena.cachix.org"
        "https://hyprland.cachix.org"
        "https://microvm.cachix.org"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://nichijou.cachix.org"
        "https://nix-community.cachix.org"
        "https://nixos-cn.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://numtide.cachix.org"
      ];
      # Trusted public keys
      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys="
        "nichijou.cachix.org-1:rbaTU9nLgVW9BK/HSV41vsag6A7/A/caBpcX+cR/6Ps="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixos-cn.cachix.org-1:L0jEaL6w7kwQOPlLoCR3ADx+E3Q8SEFEcB9Jaibl0Xg="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
      # Never warn about dirty Git/Mercurial trees.
      warn-dirty = false;
    };

    # Garbage collector
    gc.automatic = true;

    # List of directories to be searched for <...> file references.
    nixPath = [
      "darwin=/etc/nix/inputs/darwin"
      "home-manager=flake:home-manager"
      "nixpkgs=flake:nixpkgs"
    ];

    registry =
      lib.mapAttrs
      (n: v: {flake = v;})
      (builtins.removeAttrs inputs ["cells" "self" "nixpkgs"]);
  };

  environment.systemPackages = with pkgs; [
    home-manager
  ];
}
