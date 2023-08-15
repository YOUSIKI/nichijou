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
    rust-all = nixpkgs.symlinkJoin {
      name = "rust-all";
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
        inputs = {inherit inputs cell;};
        loader = haumea.lib.loaders.path;
        transformer = haumea.lib.transformers.liftDefault;
      }
    else {}
  )
