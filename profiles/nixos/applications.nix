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
    neovide
    spotify
    vscode-fhs
  ];
}
