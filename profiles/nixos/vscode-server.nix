{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  imports = [
    flake.inputs.nix-ld.nixosModules.nix-ld
    flake.inputs.vscode-server.nixosModules.default
  ];

  services.vscode-server.enable = true;
  services.vscode-server.enableFHS = true;
  services.vscode-server.nodejsPackage = pkgs.nodejs;

  programs.nix-ld.dev.enable = true;
}
