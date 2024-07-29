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

    imports = [
      inputs.cells.common.profiles.common-nix
      inputs.cells.common.profiles.common-packages
      inputs.cells.bcachefs.modules.bcachefs
    ];
  };
}
