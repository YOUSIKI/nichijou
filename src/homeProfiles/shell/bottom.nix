{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  catppuccin-src = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bottom";
    rev = "main";
    sha256 = "sha256-VaHX2I/Gn82wJWzybpWNqU3dPi3206xItOlt0iF6VVQ=";
  };
  themeSettings = fromTOML (readFile (catppuccin-src + "/themes/mocha.toml"));
in {
  programs.bottom = {
    enable = true;
    settings = themeSettings;
  };
}
