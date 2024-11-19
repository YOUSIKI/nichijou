{
  lib,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.programs.terminal.mcfly;
in {
  options.${namespace}.programs.terminal.mcfly = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable mcfly.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.mcfly = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      fzf.enable = true;
      fuzzySearchFactor = 3;
    };
  };
}
