{
  lib,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.programs.terminal.ssh;
in {
  options.${namespace}.programs.terminal.ssh = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable SSH.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      includes = [
        "~/.ssh/config.d/*"
        "~/.orbstack/ssh/config"
      ];
    };
    home.file = {
      ".ssh/config.d/hakase".source = ./config.d/hakase;
      ".ssh/config.d/nano".source = ./config.d/nano;
      ".ssh/config.d/satoshi".source = ./config.d/satoshi;
    };
  };
}
