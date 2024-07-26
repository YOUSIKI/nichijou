{
  inputs,
  cell,
}: let
  inherit (inputs.std.data) configs;
  inherit (inputs.std.lib.dev) mkNixago;
in {
  # Tool Homepage: https://numtide.github.io/treefmt/
  treefmt = (mkNixago configs.treefmt) {
    # Defaults: https://github.com/divnix/std/blob/main/src/data/configs/treefmt.nix
  };
}
