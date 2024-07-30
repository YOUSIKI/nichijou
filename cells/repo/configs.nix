{
  inputs,
  cell,
}: let
  inherit (inputs.std.lib.dev) mkNixago;
  inherit (inputs.std.lib) cfg;
  inherit (inputs) nixpkgs;
in {
  # Tool Homepage: https://numtide.github.io/treefmt/
  treefmt = mkNixago cfg.treefmt {
    data = {
      formatter = {
        nix = {
          command = "${nixpkgs.alejandra}/bin/alejandra";
          includes = ["*.nix"];
        };
        prettier = {
          command = "${nixpkgs.nodePackages.prettier}/bin/prettier";
          options = [
            "--plugin=${nixpkgs.nodePackages.prettier-plugin-toml}/lib/node_modules/prettier-plugin-toml/lib/index.js"
            "--write"
          ];
          includes = [
            "*.css"
            "*.html"
            "*.js"
            "*.json"
            "*.jsx"
            "*.md"
            "*.mdx"
            "*.scss"
            "*.ts"
            "*.yaml"
            "*.toml"
          ];
        };
        shell = {
          command = "${nixpkgs.shfmt}/bin/shfmt";
          options = ["-i" "2" "-s" "-w"];
          includes = ["*.sh"];
        };
      };
      global.excludes = [
        "**/nvfetcher/generated.json"
        "**/nvfetcher/generated.nix"
        "**/nvfetcher/*.md"
        "**/*.age"
      ];
    };
    packages = with nixpkgs; [
      alejandra
      nodePackages.prettier
      nodePackages.prettier-plugin-toml
      shfmt
    ];
  };
}
