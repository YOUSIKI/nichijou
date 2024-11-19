{
  lib,
  pkgs,
  inputs,
  system,
  ...
}: {
  # Nix configurations.
  nix = {
    settings = let
      flake = import "${inputs.self}/flake.nix";
    in {
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
    # Nix automatically detects files in the store that have identical contents, and replaces them with hard links to a single copy.
    optimise.automatic = true;
    # Garbage collector
    gc.automatic = true;
    # List of directories to be searched for <...> file references.
    nixPath =
      [
        "nixpkgs=flake:nixpkgs"
        "home-manager=flake:home-manager"
      ]
      ++ (
        lib.optional
        pkgs.stdenv.isDarwin
        "darwin=/etc/nix/inputs/darwin"
      );
    registry =
      lib.mapAttrs
      (_n: v: {flake = v;})
      (lib.filterAttrs (n: _v: !(lib.hasPrefix "nixpkgs" n) && n != "self") inputs);
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell

  # Home-manager automatically backup extension.
  home-manager.backupFileExtension = "bak";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = system;

  # Enable Homebrew for casks.
  homebrew = {
    enable = true;
    # Upgrade and uninstall homebrew casks automatically.
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # cleanup = "uninstall";
    };
  };

  # Set environment variables.
  environment.variables = {
    HOMEBREW_API_DOMAIN = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api";
    HOMEBREW_BOTTLE_DOMAIN = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles";
    HOMEBREW_BREW_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git";
    HOMEBREW_CORE_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git";
    HOMEBREW_PIP_INDEX_URL = "https://pypi.tuna.tsinghua.edu.cn/simple";
  };

  # Add homebrew taps.
  homebrew.taps = [
    "buo/cask-upgrade"
  ];
}
