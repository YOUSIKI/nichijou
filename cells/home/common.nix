{
  config,
  pkgs,
  lib,
  ...
}: {
  home.homeDirectory = lib.mkDefault (
    if pkgs.stdenv.isDarwin
    then "/Users/${config.home.username}"
    else "/home/${config.home.username}"
  );

  xdg.enable = true;

  home.stateVersion = "23.05";
}
