{flake, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  packages = with pkgs; [
    black
    isort
    poetry
    python311Full
    ruff
    ruff-lsp
  ];

  linuxPackages = with pkgs; [
    miniconda
  ];
in {
  home.packages =
    packages
    ++ (
      if pkgs.system == "x86_64-linux"
      then linuxPackages
      else []
    );

  home.file.".config/pip/pip.conf".text = ''
    [global]
    index-url = https://mirrors.pku.edu.cn/pypi/simple
  '';

  home.file.".condarc".text = ''
    changeps1: false
    channels:
      - defaults
    show_channel_urls: true
    default_channels:
      - https://mirrors.pku.edu.cn/anaconda/pkgs/main
      - https://mirrors.pku.edu.cn/anaconda/pkgs/r
    custom_channels:
      conda-forge: https://mirrors.pku.edu.cn/anaconda/cloud
      pytorch: https://mirrors.pku.edu.cn/anaconda/cloud
      bioconda: https://mirrors.pku.edu.cn/anaconda/cloud
  '';
}
