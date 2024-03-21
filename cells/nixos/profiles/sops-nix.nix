{
  inputs,
  cell,
}: {...}: {
  imports = [
    inputs.nixpkgs.sops-nix
  ];

  services.sops.enable = true;
}
