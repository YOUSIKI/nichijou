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
    inputs.nix-ld.nixosModules.nix-ld
    inputs.vscode-server.nixosModules.default
  ];

  services.vscode-server.enable = true;
  services.vscode-server.enableFHS = true;
  services.vscode-server.nodejsPackage = pkgs.nodejs;

  programs.nix-ld.dev.enable = true;
}
