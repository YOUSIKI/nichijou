{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    globals.inputs.nix-ld.nixosModules.nix-ld
    globals.inputs.nixos-vscode-server.nixosModules.default
  ];

  services.vscode-server.enable = true;
  services.vscode-server.installPath = "$HOME/.vscode-server";

  programs.nix-ld.enable = true;

  services.openssh.extraConfig = ''
    AcceptEnv NIX_LD NIX_LD_LIBRARY_PATH
  '';

  environment.etc."vscode-server-support".source = pkgs.stdenv.mkDerivation {
    name = "vscode-server-support";
    phases = ["installPhase"];
    installPhase = ''
      set -e
      mkdir -p $out
      for lib in ${pkgs.glibc}/lib/ld-linux* ${pkgs.stdenv.cc.cc.lib}/lib/*; do
        ln -sf $lib $out/$(basename $lib)
      done
    '';
  };
}
