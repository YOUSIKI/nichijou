{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs haumea hive;
  inherit (inputs.nixpkgs) lib;
in {
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

  importModule = path: let
    mod = import path;
  in
    {
      options,
      config,
      pkgs,
      lib,
      ...
    } @ args:
      mod (args // {inherit options config pkgs lib inputs;});

  localPkgs =
    if nixpkgs.stdenv.isLinux
    then inputs.nixpkgs-nixos.legacyPackages.${nixpkgs.system}
    else inputs.nixpkgs-darwin.legacyPackages.${nixpkgs.system};
}
