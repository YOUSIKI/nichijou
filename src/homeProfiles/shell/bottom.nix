{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  sources = pkgs.callPackage (globals.root + /_sources/generated.nix) {};
  catppuccin-src = sources.catppuccin-bottom.src;
  themeSettings = fromTOML (readFile (catppuccin-src + "/themes/mocha.toml"));
in {
  programs.bottom = {
    enable = true;
    settings = themeSettings;
  };
}
