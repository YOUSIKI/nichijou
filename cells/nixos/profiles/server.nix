{
  inputs,
  cell,
}: {...}: {
  imports = [
    inputs.nixos-vscode-server.nixosModules.default
  ];

  services.vscode-server.enable = true;
}
