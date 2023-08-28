{flake}: let
  inherit (flake.inputs.nixpkgs) lib;
in
  builtins // lib
