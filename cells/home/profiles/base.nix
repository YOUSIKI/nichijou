{
  inputs,
  cell,
}: {pkgs, ...}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs cell;};
  };
}
