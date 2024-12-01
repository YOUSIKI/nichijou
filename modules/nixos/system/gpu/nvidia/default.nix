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
        # TODO: remove this when https://github.com/NixOS/nixpkgs/issues/357643 is fixed.
        package = config.boot.kernelPackages.nvidiaPackages.beta;
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
  };
}
