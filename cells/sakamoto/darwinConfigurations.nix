{
  inputs,
  cell,
}: let
in {
  sakamoto = {
    bee = rec {
      system = "x86_64-darwin";
      darwin = inputs.darwin;
      home = inputs.home-manager;
      pkgs = import inputs.nixpkgs-darwin {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [
        ];
      };
    };
  };
}
