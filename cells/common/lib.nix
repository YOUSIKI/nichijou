{
  inputs,
  cell,
}: let
  inherit (inputs) haumea;

  defaultAsRoot = _: mod: mod.default or mod;
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

  importProfiles = {
    src,
    args ? {},
  }:
    haumea.lib.load {
      inherit src;
      inputs = args;
      transformer = haumea.lib.transformers.liftDefault;
    };
}
