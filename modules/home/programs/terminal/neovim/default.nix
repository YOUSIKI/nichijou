{
  lib,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.programs.terminal.neovim;
in {
  options.${namespace}.programs.terminal.neovim = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable neovim.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
