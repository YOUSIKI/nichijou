{
  inputs,
  cell,
}: {
  config,
  pkgs,
  lib,
  ...
}: let
  l = builtins // lib;
in {
  home.file.".ssh/config".text = ''
    Include ~/.orbstack/ssh/config

    Include ~/.openbayes/ssh/config

    Host satoshi
      HostName satoshi.siki.moe
      User yousiki
      Port 22

    Host hakase
      HostName hakase.siki.moe
      User yousiki
      Port 22

    Host satoshi-cf
      HostName satoshi-ssh.siki.moe
      User yousiki
      Port 22
      ProxyCommand cloudflared access ssh --hostname %h

    Host hakase-cf
      HostName hakase-ssh.siki.moe
      User yousiki
      Port 22
      ProxyCommand cloudflared access ssh --hostname %h
  '';
}
