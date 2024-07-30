{
  inputs,
  cell,
}: {
  common-nvidia-gpu = {
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

    hardware.nvidia-container-toolkit.enable = with config.virtualisation; (docker.enable || podman.enable);
  };
}
