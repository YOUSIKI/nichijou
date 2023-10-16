{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: let
  sources = pkgs.callPackage (globals.root + /_sources/generated.nix) {};
in {
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-configtool
      fcitx5-gtk
      fcitx5-rime
      fcitx5-with-addons
    ];
  };

  home.file.".local/share/fcitx5/rime" = {
    source = sources.rime-ice.src;
    recursive = true;
  };
  home.file.".local/share/fcitx5/conf/classicui.conf".text = ''
    Theme=catppuccin-mocha
  '';
  home.file.".local/share/fcitx5/themes/catppuccin-frappe" = {
    source = sources.catppuccin-fcitx5.src + /src/catppuccin-frappe;
    recursive = true;
  };
  home.file.".local/share/fcitx5/themes/catppuccin-latte" = {
    source = sources.catppuccin-fcitx5.src + /src/catppuccin-latte;
    recursive = true;
  };
  home.file.".local/share/fcitx5/themes/catppuccin-macchiato" = {
    source = sources.catppuccin-fcitx5.src + /src/catppuccin-macchiato;
    recursive = true;
  };
  home.file.".local/share/fcitx5/themes/catppuccin-mocha" = {
    source = sources.catppuccin-fcitx5.src + /src/catppuccin-mocha;
    recursive = true;
  };
}
