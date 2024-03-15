# Install NVIDIA GPU driver and configurations.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = false;
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
  };
  virtualisation.docker = {
    enableNvidia = true;
    daemon.settings.default-runtime = "nvidia";
  };
}
