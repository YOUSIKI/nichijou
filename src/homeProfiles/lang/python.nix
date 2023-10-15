{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    black
    isort
    poetry
    python3
    ruff
    ruff-lsp
  ];

  xdg.configFile."pip/pip.conf".source = globals.root + /static/configs/pip/pip.conf;

  home.file.".condarc".source = globals.root + /static/configs/conda/condarc;
}
