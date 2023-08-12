{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) nixpkgs treefmt-nix;

  formatter = (treefmt-nix.lib.evalModule nixpkgs ./treefmt.nix).config.build.wrapper;
in
  formatter
