{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    tectonic
    texliveFull
  ];
}
