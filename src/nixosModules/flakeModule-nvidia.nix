{...}: {
  flake.nixosModules.nvidia = {...}: {
    services.xserver.videoDrivers = ["nvidia"];

    hardware = {
      nvidia = {
        modesetting.enable = true;
        nvidiaSettings = true;
        open = false;
      };

      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
    };

    nixpkgs.config = {
      allowUnfree = true;
      cudaSupport = true;
    };

    virtualisation = {
      containers.cdi.dynamic.nvidia.enable = true;
      docker.enableNvidia = true;
    };
  };
}
