{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
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
