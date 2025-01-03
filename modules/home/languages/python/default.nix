{
  lib,
  pkgs,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.languages.python;

  condarc = ''
    channels:
      - defaults
    changeps1: false
    show_channel_urls: true
    auto_activate_base: false
    default_channels:
      - https://mirrors.pku.edu.cn/anaconda/pkgs/main
      - https://mirrors.pku.edu.cn/anaconda/pkgs/r
    custom_channels:
      Paddle: https://mirrors.pku.edu.cn/anaconda/cloud
      bioconda: https://mirrors.pku.edu.cn/anaconda/cloud
      conda-forge: https://mirrors.pku.edu.cn/anaconda/cloud
      intel: https://mirrors.pku.edu.cn/anaconda/cloud
      numba: https://mirrors.pku.edu.cn/anaconda/cloud
      pytorch3d: https://mirrors.pku.edu.cn/anaconda/cloud
      pytorch: https://mirrors.pku.edu.cn/anaconda/cloud
      rapidsai: https://mirrors.pku.edu.cn/anaconda/cloud
  '';

  ryeconfig = ''
    [[sources]]
    name = "default"
    url = "https://pypi.tuna.tsinghua.edu.cn/simple"
  '';

  pipconfig = ''
    [global]
    index-url = https://pypi.tuna.tsinghua.edu.cn/simple
  '';
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
        ".condarc".text = condarc;
        ".mambarc".text = condarc;
        ".rye/config.toml".text = ryeconfig;
        ".config/pip/pip.conf".text = pipconfig;
      };
    };
    programs.zsh.initExtra = ''
      if [[ -x "$(command -v micromamba)" ]]; then
        eval "$(micromamba shell hook --shell zsh)"
      fi
    '';
  };
}
