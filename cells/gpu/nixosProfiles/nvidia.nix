{pkgs, ...}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    nvidia = {
      modesetting.enable = true; # Enable modesetting.
      nvidiaSettings = true; # Enable nvidia settings.
      open = false; # Use proprietary driver.
    };

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libGL
      ];
    };

    # Enable nvidia container toolkit.
    nvidia-container-toolkit.enable = true;
  };
}
