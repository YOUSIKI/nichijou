{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    globals.inputs.nix-index-database.hmModules.nix-index
  ];

  programs.command-not-found.enable = false;
  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;
  programs.bash.initExtra = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';
  programs.zsh.initExtra = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';
}
