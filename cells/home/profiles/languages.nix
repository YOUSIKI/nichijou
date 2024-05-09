{
  inputs,
  cell,
}: {
  config,
  pkgs,
  lib,
  ...
}: let
  l = builtins // lib;
in {
  options = {
    bee.home-languages = l.mkOption {
      type = l.types.listOf l.types.str;
      default = ["nix"];
      description = "List of programming languages to enable.";
    };
  };

  config = l.mkMerge [
    (
      l.mkIf (l.elem "c" config.bee.home-languages) {
        home.packages = with pkgs; [
          clang-tools
          cmake
          gcc
          gnumake
          ninja
        ];
      }
    )
    (
      l.mkIf (l.elem "latex" config.bee.home-languages) {
        home.packages = with pkgs; [
          tectonic
          texliveFull
        ];
      }
    )
    (
      l.mkIf (l.elem "nix" config.bee.home-languages) {
        home.packages = with pkgs; [
          alejandra
          cachix
          deadnix
          nil
          statix
        ];
      }
    )
    (
      l.mkIf (l.elem "python" config.bee.home-languages) {
        home.packages =
          (with pkgs; [
            black
            isort
            micromamba
            poetry
            python3
            ruff
            rye
            uv
            yapf
          ])
          ++ (
            l.optional pkgs.stdenv.isLinux
            inputs.cells.nixos.packages.micromamba-env
          );

        home.file.".condarc".text = ''
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

        home.file.".config/pip/pip.conf".text = ''
          [global]
          index-url = https://mirrors.pku.edu.cn/pypi/web/simple
        '';

        programs.zsh.initExtra = ''
          if [[ -x "$(command -v conda)" ]]; then
            eval "$(conda "shell.$(basename "$SHELL")" hook)"
          fi
        '';
      }
    )
    (
      l.mkIf (l.elem "rust" config.bee.home-languages) {
        home.packages = with pkgs; [
          fenix.stable.toolchain
        ];
      }
    )
  ];
}
