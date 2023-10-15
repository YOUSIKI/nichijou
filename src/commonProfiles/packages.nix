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
    ++ (optional pkgs.stdenv.isLinux (with pkgs; [
      busybox
      cloudflare-warp
    ]));
}
