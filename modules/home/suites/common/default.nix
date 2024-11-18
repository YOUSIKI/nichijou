{
  lib,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.suites.common;
in {
  options.${namespace}.suites.common = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable common suite.";
    };
  };

  config = lib.mkIf cfg.enable {
    ${namespace} = {
      programs = {
        terminal = {
          bat.enable = true;
          btop.enable = true;
          comma.enable = true;
          direnv.enable = true;
          eza.enable = true;
          fzf.enable = true;
          gdu.enable = true;
          git.enable = true;
          mcfly.enable = true;
          starship.enable = true;
          yazi.enable = true;
          zellij.enable = true;
          zoxide.enable = true;
          zsh.enable = true;
        };
      };
    };
  };
}
