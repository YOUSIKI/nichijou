# Install packages for NixOS.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    _1password-gui
    brave
    clapper
    cloudflare-warp
    discord
    dolphin
    dragon
    firefox
    google-chrome
    handbrake
    haruna
    kitty
    motrix
    mpv
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