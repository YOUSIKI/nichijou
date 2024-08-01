{
  inputs,
  cell,
}: let
  inherit (inputs.std.lib.dev) mkNixago;
  inherit (inputs.std.lib) cfg;
  inherit (inputs.cells.repo.lib) localPkgs;
in {
  # Tool Homepage: https://github.com/berberman/nvfetcher
  nvfetcher = mkNixago {
    output = "lporg/nvfetcher.toml";
    format = "toml";
    data = let
      # Fetch from github latest release
      mkGithubRelease = repo: {
        src.github = repo;
        fetch.github = repo;
      };
    in {
      lporg = mkGithubRelease "blacktop/lporg";
    };
    packages = with localPkgs; [
      nvfetcher
    ];
  };
}
