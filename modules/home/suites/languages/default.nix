{
  lib,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.suites.languages;
in {
  options.${namespace}.suites.languages = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable languages suite.";
    };
  };

  config = lib.mkIf cfg.enable {
    ${namespace}.languages = {
      javascript.enable = true;
      nix.enable = true;
      python.enable = true;
      rust.enable = true;
    };
  };
}
