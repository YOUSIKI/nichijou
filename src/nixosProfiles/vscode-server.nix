{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    globals.inputs.nixos-vscode-server.nixosModules.default
  ];

  services.vscode-server.enable = true;
}
