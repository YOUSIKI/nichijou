{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  environment.systemPackages =
    (with pkgs; [
      cachix
      clash
      curl
      duf
      eza
      fish
      gh
      git
      helix
      nettools
      tmux
      vim
      wget
      zsh
    ])
    ++ (optionals pkgs.stdenv.isLinux (with pkgs; [
      cloudflare-warp
    ]));
}
