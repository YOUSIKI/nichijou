{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  gpakosz-tmux-src = pkgs.fetchFromGitHub {
    owner = "gpakosz";
    repo = ".tmux";
    rev = "master";
    sha256 = "sha256-LkoRWds7PHsteJCDvsBpZ80zvlLtFenLU3CPAxdEHYA=";
  };
in {
  programs.tmux = {
    enable = true;
    extraConfig = concatStringsSep "\n" [
      (readFile (gpakosz-tmux-src + "/.tmux.conf"))
      (readFile (gpakosz-tmux-src + "/.tmux.conf.local"))
    ];
  };
}
