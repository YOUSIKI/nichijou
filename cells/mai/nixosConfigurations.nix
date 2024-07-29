{
  inputs,
  cell,
}: let
in {
  hakase = {
    bee = rec {
      system = "x86_64-linux";
      home = inputs.home-manager;
      pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          cudaSupport = true;
        };
        overlays = [
        ];
      };
    };
  };
}
