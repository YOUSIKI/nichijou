# Install packages for NixOS.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    _1password-gui
    brave
    cloudflare-warp
    discord
    firefox
    google-chrome
    handbrake
    kitty
    motrix
    qbittorrent
    qq
    spotify
    steam
    vlc
    vscode
    wezterm
    zotero
  ];
}
