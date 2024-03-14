# SSH configurations for Home-manager.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  programs.ssh.extraConfig = ''
    Include ~/.orbstack/ssh/config

    Host satoshi
      HostName satoshi.mck.cn.yousiki.top
      User yousiki
      Port 22

    Host hakase
      HostName hakase.mck.cn.yousiki.top
      User yousiki
      Port 22
  '';
}
