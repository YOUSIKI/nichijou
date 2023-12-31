{
  description = "Daily configuration based on Nix and Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    haumea.url = "github:nix-community/haumea";
    haumea.inputs.nixpkgs.follows = "nixpkgs";

    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    nvfetcher.url = "github:berberman/nvfetcher";
    nvfetcher.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";

    fh.url = "github:DeterminateSystems/fh";
    fh.inputs.nixpkgs.follows = "nixpkgs";
    fh.inputs.fenix.follows = "fenix";

    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    nixos-vscode-server.url = "github:nix-community/nixos-vscode-server";
    nixos-vscode-server.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.darwin.follows = "darwin";
    agenix.inputs.home-manager.follows = "home-manager";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    arion.url = "github:hercules-ci/arion";
    arion.inputs.nixpkgs.follows = "nixpkgs";

    default-systems.url = "github:nix-systems/default";

    flake-root.url = "github:srid/flake-root";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {self, ...} @ inputs: let
    globals = {
      root = ./.;
      nixpkgs = {
        config = {
          allowUnfree = true;
        };
        overlays = [
          inputs.agenix.overlays.default
          inputs.arion.overlays.default
          inputs.fenix.overlays.default
          inputs.fh.overlays.default
          inputs.neovim-nightly-overlay.overlay
        ];
      };
      inherit self inputs;
      inherit (self) outputs;
    };
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = with inputs; [
        flake-parts.flakeModules.easyOverlay
        flake-root.flakeModule
        treefmt-nix.flakeModule
      ];

      systems = import (inputs.default-systems);

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
          inherit (globals.nixpkgs) config overlays;
        };

        treefmt.config = {
          inherit (config.flake-root) projectRootFile;
          package = pkgs.treefmt;
          programs.alejandra.enable = true;
          programs.prettier.enable = true;
          programs.stylua.enable = true;
        };

        packages = inputs.haumea.lib.load {
          src = globals.root + /src/packages;
          inputs = {inherit globals config self' inputs' pkgs system;};
          transformer = _: mod:
            if builtins.isAttrs mod
            then pkgs.lib.filterAttrs (n: v: v != null) mod
            else mod;
        };

        overlayAttrs = packages;
      };

      flake = let
        src = inputs.haumea.lib.load {
          src = globals.root + /src;
          inputs = {inherit globals;};
          loader = inputs.haumea.lib.loaders.scoped;
          transformer = [inputs.haumea.lib.transformers.liftDefault];
        };
      in {
        inherit
          (src)
          commonProfiles
          darwinConfigurations
          darwinProfiles
          homeProfiles
          nixosConfigurations
          nixosProfiles
          ;
      };
    };

  nixConfig = {
    extra-trusted-substituters = [
      "https://cache.garnix.io"
      "https://hyprland.cachix.org"
      "https://nichijou.cachix.org"
      "https://nix-community.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://numtide.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nichijou.cachix.org-1:rbaTU9nLgVW9BK/HSV41vsag6A7/A/caBpcX+cR/6Ps="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];
  };
}
