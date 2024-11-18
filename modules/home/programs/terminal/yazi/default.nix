{
  lib,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.programs.terminal.yazi;
in {
  options.${namespace}.programs.terminal.yazi = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable yazi.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
  };
}
