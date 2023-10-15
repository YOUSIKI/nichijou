{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  imports = [
    globals.inputs.hyprland.homeManagerModules.default
  ];

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.extraConfig = readFile (globals.root + /static/configs/hyprland/hyprland.conf);

  home.packages = with pkgs; [
    brightnessctl
    dolphin
    kitty
    playerctl
    wofi
  ];
}
