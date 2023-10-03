{global, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  imports = [
    global.inputs.hyprland.nixosModules.default
  ];

  programs.hyprland = let
    hyprlandPkgs = flake.inputs.hyprland.packages.${pkgs.system};
  in {
    enable = true;
    xwayland.enable = true;
    package = hyprlandPkgs.hyprland;
    portalPackage = hyprlandPkgs.xdg-desktop-portal-hyprland;
  };
}
