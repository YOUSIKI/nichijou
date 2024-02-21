# All programming languages.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  imports =
    map
    (path: (import path {inherit globals;}))
    [
      ./c.nix
      ./latex.nix
      ./nix.nix
      ./python.nix
      ./rust.nix
    ];
}
