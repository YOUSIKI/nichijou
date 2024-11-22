{
  inputs,
  channels,
  ...
}: let
  inherit (inputs) self;
  treefmtEval = inputs.treefmt-nix.lib.evalModule channels.nixpkgs "${self}/treefmt.nix";
in
  treefmtEval.config.build.check self
