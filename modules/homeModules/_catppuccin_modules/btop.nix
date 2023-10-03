{
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  github = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "btop";
    rev = "main";
    sha256 = "sha256-J3UezOQMDdxpflGax0rGBF/XMiKqdqZXuX4KMVGTxFk=";
  };
in {
  config = {
    home.file = {
      ".config/btop/themes/catppuccin-latte.theme".source = github + "/themes/catppuccin_latte.theme";
      ".config/btop/themes/catppuccin-frappe.theme".source = github + "/themes/catppuccin_frappe.theme";
      ".config/btop/themes/catppuccin-macchiato.theme".source = github + "/themes/catppuccin_macchiato.theme";
      ".config/btop/themes/catppuccin-mocha.theme".source = github + "/themes/catppuccin_mocha.theme";
    };
  };
}
