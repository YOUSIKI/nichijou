{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) haumea;
  inherit (inputs.nixpkgs-lib.lib) hasInfix hasSuffix;
  inherit (builtins) baseNameOf dirOf pathExists isAttrs;

  isNixos = path: hasSuffix ".nix" path && hasInfix "nixos" path;

  liftNixos = name: mod: (mod.default or mod.nixos or mod);

  nixosModules =
    if pathExists (inputs.self + /modules)
    then
      haumea.lib.load {
        src = inputs.self + /modules;
        loader = [
          {
            matches = isNixos;
            loader = haumea.lib.loaders.verbatim;
          }
        ];
        transformer = [
          liftNixos
        ];
      }
    else {};
in
  nixosModules
