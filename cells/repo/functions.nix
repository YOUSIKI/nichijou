{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs haumea hive;
  inherit (inputs.nixpkgs) lib;
in {
  collectWithoutRename = hive.collect // {renamer = _: target: target;};

  collectPackages = path:
    if lib.pathExists path
    then let
      sourcesPath = "${inputs.self}/nvfetcher/generated.nix";
      sources =
        if lib.pathExists sourcesPath
        then nixpkgs.callPackage sourcesPath {}
        else {};
      packages =
        lib.mapAttrs
        (n: v: nixpkgs.callPackage v {inherit sources;})
        (
          haumea.lib.load {
            src = path;
            loader = haumea.lib.loaders.path;
          }
        );
    in
      packages
    else {};

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
