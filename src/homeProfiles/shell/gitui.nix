{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  sources = pkgs.callPackage (globals.root + /_sources/generated.nix) {};
  catppuccin-src = sources.catppuccin-gitui.src;
  catppuccin-latte = readFile (catppuccin-src + "/theme/latte.ron");
  catppuccin-frappe = readFile (catppuccin-src + "/theme/frappe.ron");
  catppuccin-macchiato = readFile (catppuccin-src + "/theme/macchiato.ron");
  catppuccin-mocha = readFile (catppuccin-src + "/theme/mocha.ron");
in {
  programs.gitui = {
    enable = true;
    theme = catppuccin-mocha;
  };
}
