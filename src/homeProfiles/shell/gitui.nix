{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  catppuccin-src = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "gitui";
    rev = "main";
    sha256 = "sha256-m6Tjch6A2ZPZ3/muvb/9sEAQUZfjnWqcwyhNVeqPS2c=";
  };
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
