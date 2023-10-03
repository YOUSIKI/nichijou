{global, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  imports = [
    global.inputs.vscode-server.nixosModules.default
    global.inputs.nix-ld.nixosModules.nix-ld
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "nodejs-16.20.2"
  ];

  services.vscode-server.enable = true;
  services.vscode-server.enableFHS = true;
  # services.vscode-server.installPath = "$HOME/.vscode-server";

  programs.nix-ld.dev.enable = true;
}
