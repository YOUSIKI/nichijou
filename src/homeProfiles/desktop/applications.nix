{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    _1password-gui
    firefox
    google-chrome
    kitty
    neovide
    spotify
    steam
    vscode
    wezterm
  ];
}
