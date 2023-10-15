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

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

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
        overlays = with inputs; [
          fenix.overlays.default
        ];
      };
      inherit self inputs;
      inherit (self) outputs;
    };
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = with inputs; [
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
      }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          inherit (globals.nixpkgs) config overlays;
        };

        treefmt.config = {
          inherit (config.flake-root) projectRootFile;
          package = pkgs.treefmt;
          programs.alejandra.enable = true;
          programs.prettier.enable = true;
        };
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
      "https://nix-community.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://numtide.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];
  };
}
