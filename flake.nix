{
  description = "next generation of nichijou";

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
  };

  outputs = {std, ...} @ inputs:
    std.growOn {
      inherit inputs;
      cellsFrom = ./cells;
      cellBlocks = with std.blockTypes; [
        # Development Environments
        (nixago "configs")
        (devshells "shells")
      ];
    };
}
