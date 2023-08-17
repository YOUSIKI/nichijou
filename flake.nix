{
  description = "Daily configuration based on Nix and Flake";

  inputs = {
    nixpkgs.follows = "nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-23.05-darwin";
    nixpkgs-unfree.url = "github:numtide/nixpkgs-unfree";
    nixpkgs-unfree.inputs.nixpkgs.follows = "nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";

    std.url = "github:divnix/std";
    std.inputs.devshell.follows = "devshell";
    std.inputs.nixago.follows = "nixago";
    std.inputs.nixpkgs.follows = "nixpkgs";
    std.inputs.paisano.follows = "paisano";

    hive.url = "github:divnix/hive";
    hive.inputs.colmena.follows = "colmena";
    hive.inputs.disko.follows = "disko";
    hive.inputs.home-manager.follows = "home-manager";
    hive.inputs.nixos-generators.follows = "nixos-generators";
    hive.inputs.nixpkgs.follows = "nixpkgs";
    hive.inputs.paisano.follows = "paisano";

    haumea.url = "github:nix-community/haumea?ref=v0.2.2";
    haumea.inputs.nixpkgs.follows = "nixpkgs";

    nixago.url = "github:nix-community/nixago";
    nixago.inputs.nixpkgs.follows = "nixpkgs";

    paisano.url = "github:paisano-nix/core";
    paisano.inputs.nixpkgs.follows = "nixpkgs";

    colmena.url = "github:zhaofengli/colmena";
    colmena.inputs.nixpkgs.follows = "nixpkgs";
    colmena.inputs.stable.follows = "nixpkgs-stable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    default-systems.url = "github:nix-systems/default";

    vscode-server.url = "github:nix-community/nixos-vscode-server";

    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    std,
    hive,
    haumea,
    ...
  } @ inputs:
    std.growOn {
      inherit inputs;

      nixpkgsConfig = {
        allowUnfree = true;
        allowBroken = false;
        allowUnsupportedSystem = false;
      };

      systems = import inputs.default-systems;

      cellsFrom = ./src;

      cellBlocks = with std.blockTypes // hive.blockTypes; [
        # Repo utilities
        (devshells "devshells")
        (functions "formatter")
        (functions "lib")

        # Packages
        (installables "packages")

        # Overlays
        (functions "overlays")

        # Modules
        (functions "commonModules")
        (functions "nixosModules")
        (functions "darwinModules")
        (functions "homeModules")
        (functions "devshellModules")

        # Profiles
        (functions "commonProfiles")
        (functions "nixosProfiles")
        (functions "darwinProfiles")
        (functions "homeProfiles")
        (functions "devshellProfiles")

        # Configurations
        homeConfigurations
        nixosConfigurations
        darwinConfigurations
      ];
    }
    # Utilities
    {
      # Run `nix develop` to enter the devshell
      devShells = std.harvest self [
        "utils"
        "devshells"
      ];

      # Run `nix fmt` to format the repo
      formatter = std.harvest self [
        "utils"
        "formatter"
      ];

      # Useful functions
      lib = std.pick self [
        "utils"
        "lib"
      ];
    }
    # Packages
    {
      packages = std.harvest self [
        [
          "common"
          "packages"
        ]
      ];
    }
    # Modules
    {
      commonModules = std.pick self [
        "common"
        "commonModules"
      ];

      nixosModules = std.pick self [
        "nixos"
        "nixosModules"
      ];

      darwinModules = std.pick self [
        "darwin"
        "darwinModules"
      ];

      homeModules = std.pick self [
        "home"
        "homeModules"
      ];

      devshellModules = std.pick self [
        "devshell"
        "devshellModules"
      ];
    }
    # Profiles
    {
      commonProfiles = std.pick self [
        "common"
        "commonProfiles"
      ];

      nixosProfiles = std.pick self [
        "nixos"
        "nixosProfiles"
      ];

      darwinProfiles = std.pick self [
        "darwin"
        "darwinProfiles"
      ];

      homeProfiles = std.pick self [
        "home"
        "homeProfiles"
      ];

      devshellProfiles = std.pick self [
        "devshell"
        "devshellProfiles"
      ];
    }
    # Configurations
    {
      nixosConfigurations = self.lib.collect self "nixosConfigurations";
      darwinConfigurations = self.lib.collect self "darwinConfigurations";
      homeConfigurations = self.lib.collect self "homeConfigurations";
    };

  nixConfig = {
    extra-trusted-substituters = [
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
    extra-trusted-public-keys = [
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
  };
}
