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
}
