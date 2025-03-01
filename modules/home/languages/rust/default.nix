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
      sessionPath = [
        "$HOME/.cargo/bin"
      ];
      file = {
        ".cargo/config.toml".source = ./config.toml;
      };
    };
  };
}
