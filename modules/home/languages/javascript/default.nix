{
  lib,
  pkgs,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.languages.javascript;
in {
  options.${namespace}.languages.javascript = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable javascript programming language.";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        nodejs
        pnpm
        yarn-berry
      ];
      file = {
        ".npmrc".source = ./.npmrc;
      };
    };
  };
}
