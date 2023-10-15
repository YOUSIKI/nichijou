{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  ignores =
    pipe
    (pkgs.fetchurl {
      url = "https://www.toptal.com/developers/gitignore/api/linux,macos,windows,vim,emacs,visualstudiocode";
      sha256 = "sha256-+k97G8+1ECyANjXyxCgLAH2HfL18xZhO4WaVetrasoU=";
    }) [
      (splitString "\n")
      (filter (s: s != "" && !hasPrefix "#" s))
    ];
in {
  programs.git = {
    enable = true;
    lfs.enable = true;
    delta.enable = true;
    userName = "yousiki";
    userEmail = "you.siki@outlook.com";
    extraConfig = {
      pull.rebase = false;
      push.followTags = true;
      core.editor = "hx";
    };
    inherit ignores;
  };
}
