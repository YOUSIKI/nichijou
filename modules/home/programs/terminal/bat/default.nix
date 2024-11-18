{
  lib,
  pkgs,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.programs.terminal.bat;
in {
  options.${namespace}.programs.terminal.bat = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable bat.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batgrep
        batman
        batpipe
        batwatch
        prettybat
      ];
    };
  };
}
