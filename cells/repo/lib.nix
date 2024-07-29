{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs haumea hive;
  inherit (inputs.nixpkgs) lib;
in {
  collectWithoutRename = hive.collect // {renamer = _: target: target;};

  callPackageWithSources = pkgs: path: let
    sourcesPath = "${inputs.self}/nvfetcher/generated.nix";
    sources =
      if lib.pathExists sourcesPath
      then pkgs.callPackage sourcesPath {}
      else {};
  in
    pkgs.callPackage path {inherit sources;};

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
