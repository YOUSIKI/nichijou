{
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  github = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bottom";
    rev = "main";
    sha256 = "sha256-VaHX2I/Gn82wJWzybpWNqU3dPi3206xItOlt0iF6VVQ=";
  };

  cfg = config.programs.bottom;
in {
  options.programs.bottom = {
    theme = mkOption {
      type = types.str;
      default = "";
      description = "The theme to use for bottom";
    };
  };

  config = mkIf (hasPrefix "catppuccin-" cfg.theme) (let
    palette = removePrefix "catppuccin-" cfg.theme;
    tomlFile = github + "/themes/${palette}.toml";
    themeSettings = fromTOML (readFile tomlFile);
  in {
    programs.bottom.settings = themeSettings;
  });
}
