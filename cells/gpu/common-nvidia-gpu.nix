{
  config,
  pkgs,
  lib,
  ...
}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = false;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libGL
    ];
  };

  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker.enableNvidia = true;
  virtualisation.podman.enableNvidia = true;
}
