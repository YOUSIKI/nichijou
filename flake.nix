{
  description = "Daily configuration based on Nix and Flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.follows = "nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    haumea.url = "github:nix-community/haumea?ref=v0.2.2";
    haumea.inputs.nixpkgs.follows = "nixpkgs";

    nixago.url = "github:nix-community/nixago";
    nixago.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";

    flake-utils.url = "github:numtide/flake-utils";

    flake-root.url = "github:srid/flake-root";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    default-systems.url = "github:nix-systems/default";

    vscode-server.url = "github:nix-community/nixos-vscode-server";

    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    nvfetcher.url = "github:berberman/nvfetcher";
    nvfetcher.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self, ...} @ inputs: let
    global = {
      inherit self inputs;
      inherit (self) outputs;
      root = ./.;
      nixpkgsConfig = {
        config = {
          allowUnfree = true;
          allowBroken = true;
          allowUnsupportedSystem = false;
        };
        overlays = [
          inputs.emacs-overlay.overlays.default
          inputs.fenix.overlays.default
          inputs.nvfetcher.overlays.default
          self.outputs.overlays.default
        ];
      };
    };
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      # Import flake-parts modules
      imports = [
        inputs.devshell.flakeModule
        inputs.flake-parts.flakeModules.easyOverlay
        inputs.flake-root.flakeModule
        inputs.treefmt-nix.flakeModule
      ];

      # Define systems (e.g. x86_64-linux, x86_64-darwin, etc.)
      systems = import (inputs.default-systems);

      # Flake outputs that are not system-specific
      flake = let
        modules = inputs.haumea.lib.load {
          src = global.root + /modules;
          inputs = {inherit global;};
        };
        profiles = inputs.haumea.lib.load {
          src = global.root + /profiles;
          inputs = {inherit global;};
        };
        configurations = inputs.haumea.lib.load {
          src = global.root + /configurations;
          inputs = {inherit global;};
          transformer = [inputs.haumea.lib.transformers.liftDefault];
        };
      in {
        inherit (modules) homeModules;
        inherit (profiles) commonProfiles nixosProfiles darwinProfiles homeProfiles;
        inherit (configurations) nixosConfigurations darwinConfigurations;
      };

      # Flake outputs that are system-specific
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: rec {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          inherit (global.nixpkgsConfig) config overlays;
        };

        treefmt.config = {
          inherit (config.flake-root) projectRootFile;
          package = pkgs.treefmt;
          programs.alejandra.enable = true;
          programs.prettier.enable = true;
          programs.stylua.enable = true;
        };

        packages = let
          sources =
            if builtins.pathExists (global.root + /sources/generated.nix)
            then pkgs.callPackage (global.root + /sources/generated.nix) {}
            else {};
          localPkgs =
            builtins.mapAttrs (
              n: v: pkgs.callPackage v {source = sources.${n} or {};}
            )
            (
              inputs.haumea.lib.load {
                src = global.root + /packages;
                loader = inputs.haumea.lib.loaders.path;
              }
            );
          remotePkgs = {
            nvfetcher = inputs'.nvfetcher.packages.default;
          };
        in
          localPkgs // remotePkgs;

        overlayAttrs = packages;

        devshells.default = {
          packages = with pkgs; [
            alejandra
            gh
            git
            helix
            nvfetcher
          ];
        };
      };
    };

  nixConfig = {
    extra-trusted-substituters = [
      "https://cache.garnix.io"
      "https://hyprland.cachix.org"
      "https://microvm.cachix.org"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://nichijou.cachix.org"
      "https://nix-community.cachix.org"
      "https://nixos-cn.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://numtide.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "microvm.cachix.org-1:oXnBc6hRE3eX5rSYdRyMYXnfzcCxC7yKPTbZXALsqys="
      "nichijou.cachix.org-1:rbaTU9nLgVW9BK/HSV41vsag6A7/A/caBpcX+cR/6Ps="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixos-cn.cachix.org-1:L0jEaL6w7kwQOPlLoCR3ADx+E3Q8SEFEcB9Jaibl0Xg="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];
  };
}
