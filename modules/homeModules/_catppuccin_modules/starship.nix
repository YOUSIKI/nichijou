{
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  github = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "starship";
    rev = "main";
    sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
  };

  cfg = config.programs.starship;
in {
  options.programs.starship = {
    theme = mkOption {
      type = types.str;
      default = "";
      description = "The theme to use for starship";
    };
  };

  config = mkIf (hasPrefix "catppuccin-" cfg.theme) (let
    palette = removePrefix "catppuccin-" cfg.theme;
    tomlFile = github + "/palettes/${palette}.toml";
  in {
    programs.starship.settings =
      {
        format = "$all"; # Remove this line to disable the default prompt format
        palette = "catppuccin_${palette}";
      }
      // fromTOML (readFile tomlFile);
  });
}
