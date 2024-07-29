{
  description = "next generation of nichijou";

  outputs = {
    self,
    std,
    hive,
    ...
  } @ inputs: let
    blockTypes = std.blockTypes // hive.blockTypes;
  in
    hive.growOn {
      inherit inputs;
      nixpkgsConfig = {
        allowUnfree = true;
      };
      cellsFrom = ./cells;
      cellBlocks = with blockTypes; [
        # Development Environments
        (nixago "configs")
        (devshells "devshells")
        # Helper Functions
        (functions "lib")
        # Packages
        (installables "packages")
        # Configurations
        nixosConfigurations
        darwinConfigurations
        colmenaConfigurations
      ];
    } rec {
      lib = std.pick self [["repo" "lib"]];
      devShells = std.harvest self [["repo" "devshells"]];
      packages = lib.filterPackagesByPlatform (std.harvest self [["lporg" "packages"]]);
      nixosConfigurations = lib.collectWithoutRename self "nixosConfigurations";
      darwinConfigurations = lib.collectWithoutRename self "darwinConfigurations";
    };

  inputs = {
    std = {
      url = "github:divnix/std";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixago.follows = "nixago";
        devshell.follows = "devshell";
      };
    };

    hive = {
      url = "github:divnix/hive";
      inputs = {
        std.follows = "std";
        nixpkgs.follows = "nixpkgs";
        nixago.follows = "nixago";
        devshell.follows = "devshell";
        colmena.follows = "colmena";
      };
    };

    haumea = {
      url = "github:nix-community/haumea";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixago = {
      url = "github:nix-community/nixago";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixos-vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  nixConfig = rec {
    substituters = [
      "https://cache.nixos.org?priority=45"
      "https://mirror.sjtu.edu.cn/nix-channels/store?priority=25"
      "https://mirrors.cqupt.edu.cn/nix-channels/store?priority=35"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=25"
      "https://mirrors.ustc.edu.cn/nix-channels/store?priority=35"
      "https://nix-community.cachix.org?priority=40"
      "https://numtide.cachix.org?priority=40"
    ];
    trusted-substituters = substituters;
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];
  };
}
