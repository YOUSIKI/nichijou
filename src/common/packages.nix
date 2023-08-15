{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) haumea nixpkgs;

  sources = {}; # TODO: Add sources from nvfetcher.
in
  {
    # Add std as package so that we can build and push to cachix.
    std = inputs.std.packages.std;
  }
  // nixpkgs.lib.mapAttrs (
    name: value:
      nixpkgs.callPackage value {
        inherit inputs cell;
        source =
          if sources ? name
          then sources.${name}
          else null;
      }
  )
  (
    if builtins.pathExists ./packages
    then
      haumea.lib.load {
        src = ./packages;
        inputs = {inherit inputs cell;};
        loader = haumea.lib.loaders.path;
        transformer = haumea.lib.transformers.liftDefault;
      }
    else {}
  )
