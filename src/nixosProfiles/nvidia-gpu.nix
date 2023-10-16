{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  nixpkgs.config.cudaSupport = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = mkForce true; # required by nvidia-docker.
  virtualisation.docker = {
    enableNvidia = true;
    daemon.settings.default-runtime = "nvidia";
  };
  environment.systemPackages = with pkgs; [
    nvitop
    nvtop
    python311Packages.gpustat
  ];
  programs.hyprland.enableNvidiaPatches = mkForce true;
}
