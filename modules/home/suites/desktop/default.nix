{
  lib,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.suites.desktop;
in {
  options.${namespace}.suites.desktop = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable desktop suite.";
    };
  };

  config = lib.mkIf cfg.enable {
    ${namespace} = {
      programs = {
        terminal = {
          wezterm.enable = true;
        };
      };
    };
  };
}
