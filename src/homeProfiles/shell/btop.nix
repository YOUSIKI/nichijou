{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: let
  sources = pkgs.callPackage (globals.root + /_sources/generated.nix) {};
  catppuccin-src = sources.catppuccin-btop.src;
in {
  programs.btop = {
    enable = true;
    settings.color_scheme = "catppuccin-mocha";
  };

  xdg.configFile."btop/themes/catppuccin-latte.theme".source = catppuccin-src + "/themes/catppuccin_latte.theme";
  xdg.configFile."btop/themes/catppuccin-frappe.theme".source = catppuccin-src + "/themes/catppuccin_frappe.theme";
  xdg.configFile."btop/themes/catppuccin-macchiato.theme".source = catppuccin-src + "/themes/catppuccin_macchiato.theme";
  xdg.configFile."btop/themes/catppuccin-mocha.theme".source = catppuccin-src + "/themes/catppuccin_mocha.theme";
}
