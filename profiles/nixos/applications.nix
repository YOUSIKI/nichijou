{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  environment.systemPackages = with pkgs; [
    _1password-gui
    cloudflare-warp
    firefox
    google-chrome
    jetbrains.pycharm-professional
    neovide
    spotify
    vscode-fhs
  ];
}
