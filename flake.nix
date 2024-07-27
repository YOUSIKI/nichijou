{
  description = "next generation of nichijou";

  outputs = {
    self,
    std,
    ...
  } @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = ./cells;
      cellBlocks = with std.blockTypes; [
        # Development Environments
        (nixago "configs")
        (devshells "shells")
        # Packages
        (installables "packages")
      ];
    } {
      devShells = std.harvest self [["repo" "shells"]];
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

    std = {
      url = "github:divnix/std";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        devshell.url = "github:numtide/devshell";
        nixago.url = "github:nix-community/nixago";
      };
    };

    haumea = {
      url = "github:nix-community/haumea";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
