{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true; # required by nvidia-docker.
  virtualisation.docker = {
    enableNvidia = true;
    daemon.settings.default-runtime = "nvidia";
  };
  # programs.hyprland.nvidiaPatches = true;
  environment.systemPackages = with pkgs; [
    nvitop
    nvtop
    python311Packages.gpustat
  ];
}
