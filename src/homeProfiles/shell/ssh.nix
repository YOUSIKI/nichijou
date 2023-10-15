{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    openssh
    ssh-copy-id
    sshfs
    sshping
  ];

  home.file.".ssh" = {
    source = globals.root + /static/configs/ssh;
    recursive = true;
  };
}
