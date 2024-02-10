# LaTeX configurations.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  home.packages = with pkgs; [
    tectonic
    texlive.combined.scheme-full
  ];
}
