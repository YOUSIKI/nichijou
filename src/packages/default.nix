{
  globals,
  config,
  self',
  inputs',
  pkgs,
  system,
  ...
}:
with builtins // pkgs.lib; let
  sources = pkgs.callPackage (globals.root + /_sources/generated.nix) {};
  src = ./_platforms/${system};
  loader = inputs: path: pkgs.callPackage path {inherit sources;};
in
  if pathExists src
  then
    globals.inputs.haumea.lib.load {
      inherit src loader;
    }
  else {}
