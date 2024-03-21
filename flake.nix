{
  description = "Personal nix configurations";

  outputs = {
    self,
    hive,
    std,
    nixpkgs,
    ...
  } @ inputs: let
    collect = hive.collect // {renamer = _: target: target;};
  in
    hive.growOn {
      inherit inputs;

      systems = import inputs.default-systems;

      nixpkgsConfig = {
        allowUnfree = true;
      };

      cellsFrom = ./cells;

      cellBlocks = [
        (std.blockTypes.functions "lib")

        (std.blockTypes.nixago "configs")

        (std.blockTypes.devshells "devshells")

        (std.blockTypes.functions "commonProfiles")
        (std.blockTypes.functions "homeModules")
        (std.blockTypes.functions "homeProfiles")
        (std.blockTypes.functions "nixosModules")
        (std.blockTypes.functions "nixosProfiles")

        hive.blockTypes.nixosConfigurations
      ];
    }
    {
      devShells = hive.harvest self [["common" "devshells"]];
    }
    {
      nixosModules = hive.pick self [["nixos" "nixosModules"]];
    }
    {
      nixosConfigurations = collect self "nixosConfigurations";
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hive = {
      url = "github:divnix/hive";
      inputs = {
        colmena.follows = "colmena";
        nixago.follows = "nixago";
        nixpkgs.follows = "nixpkgs";
      };
    };

    std.follows = "hive/std";

    nixago = {
      url = "github:nix-community/nixago";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    haumea = {
      url = "github:nix-community/haumea";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    default-systems.url = "github:nix-systems/default";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixos-vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvfetcher = {
      url = "github:berberman/nvfetcher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = rec {
    substituters = [
      # "https://cache.garnix.io?priority=50" # Disable in China
      "https://cache.nixos.org?priority=45"
      "https://cuda-maintainers.cachix.org?priority=40"
      "https://hyprland.cachix.org?priority=40"
      "https://mirror.sjtu.edu.cn/nix-channels/store?priority=25"
      "https://mirrors.cqupt.edu.cn/nix-channels/store?priority=35"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=30"
      "https://mirrors.ustc.edu.cn/nix-channels/store?priority=35"
      "https://nichijou.cachix.org?priority=40"
      "https://nix-community.cachix.org?priority=40"
      "https://nixpkgs-wayland.cachix.org?priority=40"
      "https://numtide.cachix.org?priority=40"
    ];
    trusted-substituters = substituters;
    trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nichijou.cachix.org-1:rbaTU9nLgVW9BK/HSV41vsag6A7/A/caBpcX+cR/6Ps="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
    ];
  };
}
