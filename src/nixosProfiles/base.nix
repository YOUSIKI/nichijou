{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  services.openssh.enable = true;
  services.openssh.openFirewall = true;
  programs.mosh.enable = true;

  # networking.wireless.enable = true;
  networking.networkmanager.enable = true;

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [22];
  networking.firewall.allowedUDPPortRanges = [
    # Mosh uses UDP ports in range [60000, 61000]
    {
      from = 60000;
      to = 61000;
    }
  ];

  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  i18n.supportedLocales = ["all"];
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  hardware.bluetooth.enable = true;

  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  system.stateVersion = "23.05";
}
