{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: let
  hyprlandPkgs = globals.inputs.hyprland.packages.${pkgs.system};
in {
  imports = [
    globals.inputs.hyprland.nixosModules.default
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = hyprlandPkgs.hyprland;
    portalPackage = hyprlandPkgs.xdg-desktop-portal-hyprland;
  };
}
