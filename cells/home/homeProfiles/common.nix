{
  cell,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    cell.homeProfiles.shell
    cell.homeProfiles.ssh
  ];

  home.homeDirectory = lib.mkDefault (
    if pkgs.stdenv.isDarwin
    then "/Users/${config.home.username}"
    else "/home/${config.home.username}"
  );

  xdg.enable = true;

  home.stateVersion = "24.05";
}
