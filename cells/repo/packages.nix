{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs haumea;

  packagesPath = "${inputs.self}/packages";
  nvfetcherPath = "${packagesPath}/nvfetcher/generated.nix";
  recipesPath = "${packagesPath}/recipes";

  sources =
    if nixpkgs.lib.pathExists nvfetcherPath
    then nixpkgs.callPackage nvfetcherPath {}
    else {};

  recipePaths =
    if nixpkgs.lib.pathExists recipesPath
    then
      haumea.lib.load {
        src = recipesPath;
        loader = haumea.lib.loaders.path;
      }
    else {};

  packages =
    nixpkgs.lib.mapAttrs
    (n: v: nixpkgs.callPackage v {inherit sources;})
    recipePaths;
in
  packages
