{
  lib,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.programs.terminal.direnv;
in {
  options.${namespace}.programs.terminal.direnv = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable direnv.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
