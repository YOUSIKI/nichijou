{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: let
  sources = pkgs.callPackage (globals.root + /_sources/generated.nix) {};
  catppuccin-src = sources.catppuccin-bat.src;
  catppuccin-latte = {
    src = catppuccin-src;
    file = "Catppuccin-latte.tmTheme";
  };
  catppuccin-frappe = {
    src = catppuccin-src;
    file = "Catppuccin-frappe.tmTheme";
  };
  catppuccin-macchiato = {
    src = catppuccin-src;
    file = "Catppuccin-macchiato.tmTheme";
  };
  catppuccin-mocha = {
    src = catppuccin-src;
    file = "Catppuccin-mocha.tmTheme";
  };
in {
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batgrep
      batman
      batpipe
      batwatch
      prettybat
    ];
    config.theme = "catppuccin-mocha";
    themes = {
      inherit
        catppuccin-latte
        catppuccin-frappe
        catppuccin-macchiato
        catppuccin-mocha
        ;
    };
  };
}
