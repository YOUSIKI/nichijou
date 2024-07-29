{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs haumea;
  inherit (nixpkgs) lib;

  sources = let
    sourcesPath = "${inputs.self}/nvfetcher/generated.nix";
  in
    if lib.pathExists sourcesPath
    then nixpkgs.callPackage sourcesPath {}
    else {};

  packages =
    lib.mapAttrs (n: v: nixpkgs.callPackage v {inherit sources;})
    (
      if lib.pathExists ./packages
      then
        haumea.lib.load {
          src = ./packages;
          loader = haumea.lib.loaders.path;
        }
      else {}
    );
in
  packages
