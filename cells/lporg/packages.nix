{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;

  sourcesPath = "${inputs.self}/lporg/nvfetcher/generated.nix";
  sources = nixpkgs.callPackage sourcesPath {};
  recipePath = ./lporg.nix;
in {
  lporg = nixpkgs.callPackage recipePath {
    inherit (sources.lporg) pname version src;
  };
}
