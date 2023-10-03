{
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  github = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bat";
    rev = "main";
    sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
  };
in {
  config = {
    programs.bat = {
      themes = {
        catppuccin-latte = readFile (github + "/Catppuccin-latte.tmTheme");
        catppuccin-frappe = readFile (github + "/Catppuccin-frappe.tmTheme");
        catppuccin-macchiato = readFile (github + "/Catppuccin-macchiato.tmTheme");
        catppuccin-mocha = readFile (github + "/Catppuccin-mocha.tmTheme");
      };
    };
  };
}
