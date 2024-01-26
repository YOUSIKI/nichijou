{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: with builtins // lib; {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yousiki = {
    isNormalUser = true;
    extraGroups = ["wheel" "sudo" "docker" "podman" "lxd"];
    shell = pkgs.zsh;
  };

  # Make sure zsh is enabled.
  programs.zsh.enable = true;

  # Enable ssh.
  services.openssh.enable = mkDefault true;
  services.openssh.openFirewall = mkDefault true;

  # networking.wireless.enable = true;
  networking.networkmanager.enable = true;

  networking.firewall.enable = true;

  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = ["all"];

  services.xserver = {
    layout = "cn";
    xkbVariant = "";
  };

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  
  hardware.bluetooth.enable = true;

  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "23.11";
}
