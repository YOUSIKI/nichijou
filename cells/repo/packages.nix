{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs haumea;

  importPackages = {
    src,
    args ? {},
  }: let
    paths = haumea.lib.load {
      inherit src;
      loader = haumea.lib.loaders.path;
    };
    pkgs =
      nixpkgs.lib.mapAttrs
      (n: v: nixpkgs.callPackage v args)
      paths;
  in
    if nixpkgs.lib.pathExists src
    then pkgs
    else {};
in
  importPackages {
    src = "${inputs.self}/packages";
  }
