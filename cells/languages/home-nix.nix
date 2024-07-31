{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    alejandra
    cachix
    deadnix
    nil
    statix
  ];
}
