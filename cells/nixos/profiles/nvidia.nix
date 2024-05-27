{
  inputs,
  cell,
}: {pkgs, ...}: {
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
    extraPackages = with pkgs; [
      libGL
    ];
    setLdLibraryPath = true;
  };

  hardware.nvidia-container-toolkit.enable = true;

  virtualisation.docker.enableNvidia = true;
}
