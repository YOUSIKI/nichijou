{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  sources = pkgs.callPackage (globals.root + /_sources/generated.nix) {};
  catppuccin-src = sources.catppuccin-starship.src;
  catppuccin-latte = fromTOML (readFile (catppuccin-src + "/palettes/latte.toml"));
  catppuccin-frappe = fromTOML (readFile (catppuccin-src + "/palettes/frappe.toml"));
  catppuccin-macchiato = fromTOML (readFile (catppuccin-src + "/palettes/macchiato.toml"));
  catppuccin-mocha = fromTOML (readFile (catppuccin-src + "/palettes/mocha.toml"));
in {
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableIonIntegration = true;
    enableNushellIntegration = true;
    enableTransience = true;
    settings =
      {
        format = "$all";
        palette = "catppuccin_mocha";
      }
      // catppuccin-latte
      // catppuccin-frappe
      // catppuccin-macchiato
      // catppuccin-mocha;
  };
}
