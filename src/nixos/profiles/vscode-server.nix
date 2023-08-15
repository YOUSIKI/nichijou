{
  inputs,
  cell,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // inputs.nixpkgs.lib; {
  imports = [
    inputs.vscode-server.nixosModules.default
  ];

  services.vscode-server.enable = true;
}
