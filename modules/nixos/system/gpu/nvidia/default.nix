{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  cfg = config.${namespace}.system.gpu.nvidia;
in {
  options.${namespace}.system.gpu.nvidia = {
    enable = lib.mkEnableOption "Whether to enable NVIDIA GPU support";
  };

  config = lib.mkIf cfg.enable {
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

    environment.sessionVariables = {
      LD_LIBRARY_PATH = "/run/opengl-driver/lib:${pkgs.glibc}/lib:${pkgs.glib.out}/lib";
    };
  };
}
