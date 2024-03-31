{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs haumea;

  l = nixpkgs.lib // builtins;

  defaultAsRoot = _: mod: mod.default or mod;
  defaultSourcesPath = "${inputs.self}/nvfetcher/generated.nix";
  defaultSources =
    if l.pathExists defaultSourcesPath
    then nixpkgs.callPackage defaultSourcesPath {}
    else null;
in {
  importConfigurations = {
    src,
    args ? {},
  }:
    haumea.lib.load {
      inherit src;
      inputs = args;
      transformer = defaultAsRoot;
    };

  importModules = {
    src,
    args ? {},
  }:
    haumea.lib.load {
      inherit src;
      inputs = args;
      transformer = haumea.lib.transformers.liftDefault;
    };

  importProfiles = {
    src,
    args ? {},
  }:
    haumea.lib.load {
      inherit src;
      inputs = args;
      transformer = haumea.lib.transformers.liftDefault;
    };

  importPackages = {
    src,
    args ? {},
    sources ? defaultSources,
  }: let
    paths = haumea.lib.load {
      inherit src;
      loader = haumea.lib.loaders.path;
    };
    pkgs =
      l.mapAttrs
      (n: v: nixpkgs.callPackage v (args // {inherit sources;}))
      paths;
  in
    pkgs;
}
