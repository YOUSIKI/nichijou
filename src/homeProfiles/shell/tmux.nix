{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  sources = pkgs.callPackage (globals.root + /_sources/generated.nix) {};
  gpakosz-tmux-src = sources.gpakosz-tmux.src;
in {
  programs.tmux = {
    enable = true;
    extraConfig = concatStringsSep "\n" [
      (readFile (gpakosz-tmux-src + "/.tmux.conf"))
      (readFile (gpakosz-tmux-src + "/.tmux.conf.local"))
    ];
  };
}
