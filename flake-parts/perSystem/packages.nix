{
  config,
  self',
  inputs',
  pkgs,
  system,
  flake,
  ...
}: let
  sources =
    if builtins.pathExists (flake.root + /sources/generated.nix)
    then pkgs.callPackage (flake.root + /sources/generated.nix) {}
    else {};

  localPackages =
    builtins.mapAttrs (
      n: v: pkgs.callPackage v {source = sources.${n} or {};}
    )
    (
      flake.inputs.haumea.lib.load {
        src = flake.root + /packages;
        loader = flake.inputs.haumea.lib.loaders.path;
      }
    );

  remotePackages = {
    nvfetcher = inputs'.nvfetcher.packages.default;
  };
in
  localPackages // remotePackages
