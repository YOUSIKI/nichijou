{
  lib,
  pkgs,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.programs.graphical.kitty;
in {
  options.${namespace}.programs.graphical.kitty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable kitty.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      font = {
        name = "CaskaydiaCove Nerd Font Mono";
        size = 13;
        package = pkgs.nerd-fonts.caskaydia-mono;
      };
      shellIntegration = {
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
      themeFile = "Catppuccin-Mocha";
    };
  };
}
