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
