{
  lib,
  pkgs,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.languages.rust;
in {
  options.${namespace}.languages.rust = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable rust programming language.";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        rustup
      ];
    };
    home.sessionPath = [
      "$HOME/.cargo/bin"
    ];
  };
}
