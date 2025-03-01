{
  lib,
  pkgs,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.languages.python;
in {
  options.${namespace}.languages.python = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable python programming language.";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        micromamba
        python3
        ruff
        rye
        uv
      ];
      file = {
        ".condarc".source = ./.condarc;
        ".mambarc".source = ./.condarc;
        ".rye/config.toml".source = ./rye.toml;
        ".config/uv/uv.toml".source = ./uv.toml;
        ".config/pip/pip.conf".source = ./pip.conf;
      };
    };
    programs.zsh.initExtra = ''
      if [[ -x "$(command -v micromamba)" ]]; then
        eval "$(micromamba shell hook --shell zsh)"
      fi
    '';
  };
}
