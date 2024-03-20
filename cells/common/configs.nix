{
  inputs,
  cell,
}: let
  inherit (inputs) std nixpkgs;
in {
  treefmt = std.lib.dev.mkNixago std.lib.cfg.treefmt {
    data = {
      global.excludes = [
        "nvfetcher/generated.*"
      ];
      formatter = {
        nix = {
          command = "alejandra";
          includes = ["*.nix"];
        };
        prettier = {
          command = "prettier";
          includes = [
            "*.json"
            "*.md"
            "*.yaml"
          ];
        };
      };
    };

    packages = [
      inputs.nixpkgs.alejandra
      inputs.nixpkgs.nodePackages.prettier
    ];
  };
}
