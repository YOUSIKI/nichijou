{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  imports = [
    flake.inputs.hyprland.nixosModules.default
  ];

  programs.hyprland = let
    hyprlandPkgs = flake.inputs.hyprland.packages.${pkgs.system};
  in {
    enable = true;
    xwayland.enable = true;
    package = hyprlandPkgs.hyprland;
    portalPackage = hyprlandPkgs.xdg-desktop-portal-hyprland;
  };

  environment.systemPackages = with pkgs; [
  ];
}
