{
  lib,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.programs.terminal.zoxide;
in {
  options.${namespace}.programs.terminal.zoxide = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable zoxide.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
