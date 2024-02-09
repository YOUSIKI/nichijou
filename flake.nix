{
  description = "nix configurations for daily life";

  outputs = {self, ...} @ inputs: let
    # The global variables that can be accessed from every module.
    globals = {
      root = ./.;
      nixpkgs.overlays = [
      ];
      nixpkgs.config = {
        allowUnfree = true;
        allowBroken = false;
        allowUnsupported = false;
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
      }: rec {
        # Overwrite nixpkgs configurations.
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          inherit (globals.nixpkgs) config;
          inherit (globals.nixpkgs) overlays;
        };

        # Format files with treefmt.
        treefmt.config = {
          inherit (config.flake-root) projectRootFile;
          package = pkgs.treefmt;
          programs.alejandra.enable = true; # *.nix
          programs.prettier.enable = true; # *.json, *.yaml, *.yml
          programs.stylua.enable = true; # *.lua
        };

        packages.default = pkgs.hello;
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
          homeConfigurations
          homeProfiles
          nixosConfigurations
          nixosProfiles
          ;
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    haumea.url = "github:nix-community/haumea";
    haumea.inputs.nixpkgs.follows = "nixpkgs";

    default-systems.url = "github:nix-systems/default";

    flake-root.url = "github:srid/flake-root";

    flake-parts.url = "github:hercules-ci/flake-parts";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    nixos-vscode-server.url = "github:nix-community/nixos-vscode-server";
    nixos-vscode-server.inputs.nixpkgs.follows = "nixpkgs";
  };

  nixConfig = rec {
    substituters = [
      "https://cache.garnix.io?priority=50"
      "https://cache.nixos.org?priority=45"
      "https://hyprland.cachix.org?priority=40"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=30"
      "https://mirrors.ustc.edu.cn/nix-channels/store?priority=35"
      "https://nichijou.cachix.org?priority=40"
      "https://nix-community.cachix.org?priority=40"
      "https://nixpkgs-wayland.cachix.org?priority=40"
      "https://numtide.cachix.org?priority=40"
    ];
    trusted-substituters = [
      "https://cache.garnix.io?priority=50"
      "https://cache.nixos.org?priority=45"
      "https://hyprland.cachix.org?priority=40"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=30"
      "https://mirrors.ustc.edu.cn/nix-channels/store?priority=35"
      "https://nichijou.cachix.org?priority=40"
      "https://nix-community.cachix.org?priority=40"
      "https://nixpkgs-wayland.cachix.org?priority=40"
      "https://numtide.cachix.org?priority=40"
    ];
    trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nichijou.cachix.org-1:rbaTU9nLgVW9BK/HSV41vsag6A7/A/caBpcX+cR/6Ps="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];
  };
}
