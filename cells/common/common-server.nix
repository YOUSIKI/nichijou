{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-vscode-server.nixosModules.default
  ];
  services.vscode-server.enable = true;
  programs.nix-ld.enable = true;
}
