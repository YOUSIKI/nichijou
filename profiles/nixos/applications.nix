{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  environment.systemPackages = with pkgs; [
    _1password-gui
    firefox
    google-chrome
    jetbrains.pycharm-professional
  ];
}
