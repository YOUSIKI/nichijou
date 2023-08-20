{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) haumea nixpkgs;

  sources = {}; # TODO: Add sources from nvfetcher.
in
  {
    # Add other packages so that we can build and push to cachix.
    fenix = nixpkgs.symlinkJoin {
      name = "fenix";
      paths = [
        inputs.fenix.packages.rust-analyzer
        inputs.fenix.packages.complete.toolchain
        inputs.fenix.packages.default.toolchain
        inputs.fenix.packages.latest.toolchain
        inputs.fenix.packages.minimal.toolchain
      ];
    };
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
        loader = haumea.lib.loaders.path;
        transformer = haumea.lib.transformers.liftDefault;
      }
    else {}
  )
