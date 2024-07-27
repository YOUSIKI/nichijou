{
  inputs,
  cell,
}: let
  inherit (inputs.std.lib.dev) mkNixago;
  inherit (inputs.std.lib) cfg;
  inherit (inputs) nixpkgs;
in {
  # Tool Homepage: https://github.com/berberman/nvfetcher
  nvfetcher = mkNixago {
    output = "nvfetcher.toml";
    format = "toml";
    data = let
      # Fetch from github latest release
      mkGithubRelease = repo: {
        src.github = repo;
        fetch.github = repo;
      };
    in {
      lporg = mkGithubRelease "blacktop/lporg";
      # mihomo = mkGithubRelease "mihomo/mihomo";
    };
    packages = with inputs.nixpkgs; [nvfetcher];
  };

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
    };
    packages = with nixpkgs; [
      alejandra
      nodePackages.prettier
      nodePackages.prettier-plugin-toml
      shfmt
    ];
  };
}
