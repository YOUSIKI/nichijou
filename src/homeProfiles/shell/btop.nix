{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: let
  catppuccin-src = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "btop";
    rev = "main";
    sha256 = "sha256-J3UezOQMDdxpflGax0rGBF/XMiKqdqZXuX4KMVGTxFk=";
  };
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
