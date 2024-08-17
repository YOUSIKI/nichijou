# Graphical packages for NixOS desktop.
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    _1password-gui
    clapper
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
    warp-terminal
    # wezterm
    zed-editor
    zotero
  ];
}
