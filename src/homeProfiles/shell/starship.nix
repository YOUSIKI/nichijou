{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  catppuccin-src = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "starship";
    rev = "main";
    sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
  };
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
