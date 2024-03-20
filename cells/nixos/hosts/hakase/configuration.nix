# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "hakase";

  time.timeZone = "Asia/Shanghai";

  networking.proxy.default = "http://yousiki:yangsiqi@satoshi.mck.cn.yousiki.top:7890";
  networking.proxy.noProxy = "127.0.0.1,localhost,cn.yousiki.top,edu.cn";

  users.users.yousiki = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  services.openssh.enable = true;
  services.openssh.openFirewall = true;
}
