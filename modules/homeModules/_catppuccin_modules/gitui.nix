{
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  github = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "gitui";
    rev = "main";
    sha256 = "sha256-m6Tjch6A2ZPZ3/muvb/9sEAQUZfjnWqcwyhNVeqPS2c=";
  };
in {
  options.programs.gitui.themes = {
    catppuccin-latte = mkOption {
      type = types.str;
      default = readFile (github + "/theme/latte.ron");
      description = "Catppuccino Latte theme";
    };

    catppuccin-frappe = mkOption {
      type = types.str;
      default = readFile (github + "/theme/frappe.ron");
      description = "Catppuccino Frappe theme";
    };

    catppuccin-mocha = mkOption {
      type = types.str;
      default = readFile (github + "/theme/mocha.ron");
      description = "Catppuccino Mocha theme";
    };

    catppuccin-macchiato = mkOption {
      type = types.str;
      default = readFile (github + "/theme/macchiato.ron");
      description = "Catppuccino Macchiato theme";
    };
  };
}
