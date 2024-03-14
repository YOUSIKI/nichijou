# Install NVIDIA GPU driver and configurations.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  nixpkgs.config.cudaSupport = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  virtualisation.docker.enableNvidia = true;
  virtualisation.docker.daemon.settings.default-runtime = "nvidia";
  virtualisation.podman.enableNvidia = true;
  environment.systemPackages = with pkgs;
  with python311Packages; [
    bottom
    gpustat
    nvitop
    nvtop
  ];
}
