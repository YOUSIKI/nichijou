{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: let
  dracula = {
    src = pkgs.fetchFromGitHub {
      owner = "dracula";
      repo = "sublime"; # Bat uses sublime syntax for its themes
      rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
      sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
    };
    file = "Dracula.tmTheme";
  };
  catppuccin-src = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "bat";
    rev = "main";
    sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
  };
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
        dracula
        catppuccin-latte
        catppuccin-frappe
        catppuccin-macchiato
        catppuccin-mocha
        ;
    };
  };
}
