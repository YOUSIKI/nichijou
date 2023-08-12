{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) hive;
  inherit (inputs.nixpkgs) lib;
in
  Self: CellBlock:
    lib.mapAttrs'
    (
      name: value:
        lib.nameValuePair
        (lib.concatStringsSep "-" (builtins.tail (lib.splitString "-" name)))
        value
    )
    (hive.collect Self CellBlock)
