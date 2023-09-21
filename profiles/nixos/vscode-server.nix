{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  imports = [
    flake.inputs.vscode-server.nixosModules.default
    flake.inputs.nix-ld.nixosModules.nix-ld
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "nodejs-16.20.2"
  ];

  services.vscode-server.enable = true;
  services.vscode-server.enableFHS = true;
  # services.vscode-server.installPath = "$HOME/.vscode-server";

  programs.nix-ld.dev.enable = true;
}
