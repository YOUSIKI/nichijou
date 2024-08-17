{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs haumea hive;
  inherit (inputs.nixpkgs) lib;
in rec {
  collectWithoutRename = hive.collect // {renamer = _: target: target;};

  filterPackagesByPlatform = packages:
    lib.mapAttrs
    (
      platform: platformPackages:
        lib.filterAttrs
        (name: package: builtins.elem platform package.meta.platforms)
        platformPackages
    )
    packages;

  importModule = path: args: (
    {
      options,
      config,
      pkgs,
      lib,
      ...
    } @ extras: let
      func = import path;
      funcArgs = {inherit options config pkgs lib;} // extras // args;
    in
      func funcArgs
  );

  importModules = path: args:
    if lib.pathExists path
    then
      builtins.mapAttrs
      (n: v: importModule v args)
      (haumea.lib.load {
        src = path;
        loader = haumea.lib.loaders.path;
      })
    else {};

  localPkgs =
    if nixpkgs.stdenv.isLinux
    then inputs.nixpkgs-nixos.legacyPackages.${nixpkgs.system}
    else inputs.nixpkgs-darwin.legacyPackages.${nixpkgs.system};
}
