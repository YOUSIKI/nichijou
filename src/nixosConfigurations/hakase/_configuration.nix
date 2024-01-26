# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{
  config,
  pkgs,
  ...
}: {
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hakase"; # Define your hostname.

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Desktop Environments.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable xwayland.
  programs.xwayland.enable = true;

  programs.zsh.enable = true;

  # Disable automatic suspend.
  services.autosuspend.enable = false;

  # Configure network proxy.
  networking.proxy.default = "http://satoshi.mck.cn.yousiki.top:7890";
  networking.proxy.noProxy = "127.0.0.1,localhost,yousiki.top,ybh1998.space,pku.edu.cn";
}
