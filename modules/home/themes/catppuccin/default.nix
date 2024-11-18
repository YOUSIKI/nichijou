{
  lib,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.themes.catppuccin;
in {
  options.${namespace}.themes.catppuccin = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable catppuccin theme.";
    };

    flavor = lib.mkOption {
      type = lib.types.str;
      default = "mocha";
      description = "The flavor of the catppuccin theme.";
    };
  };

  config = lib.mkIf cfg.enable {
    catppuccin = {
      inherit (cfg) enable flavor;
    };
  };
}
