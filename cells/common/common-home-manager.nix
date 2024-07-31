{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    # extraSpecialArgs = {inherit inputs;};
  };
}
