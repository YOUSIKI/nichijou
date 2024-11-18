{
  lib,
  pkgs,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.programs.terminal.gdu;
in {
  options.${namespace}.programs.terminal.gdu = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable gdu.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gdu
    ];
  };
}
