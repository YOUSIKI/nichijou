# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{
  config,
  pkgs,
  ...
}: {
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "mai"; # Define your hostname.

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Desktop Environments.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.defaultSession = "plasma";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yousiki = {
    isNormalUser = true;
    extraGroups = ["wheel" "sudo" "docker"];
    packages = with pkgs; [
    ];
  };
}
