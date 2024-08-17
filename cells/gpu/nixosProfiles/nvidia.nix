{pkgs, ...}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    nvidia = {
      modesetting.enable = true; # Enable modesetting.
      nvidiaSettings = true; # Enable Nvidia settings.
      open = false; # Use proprietary driver.
    };

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libGL
      ];
    };

    # Enable Nvidia container toolkit.
    nvidia-container-toolkit.enable = true;
  };

  # Enable Nvidia GPU for virtualisation.
  virtualisation = {
    docker.enableNvidia = true;
    podman.enableNvidia = true;
  };
}
