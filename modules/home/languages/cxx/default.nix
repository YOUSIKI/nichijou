{
  lib,
  pkgs,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.languages.cxx;
in {
  options.${namespace}.languages.cxx = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable C++ programming language.";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        clang
        clang-tools
      ];
    };
  };
}
