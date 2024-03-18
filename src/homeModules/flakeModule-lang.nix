{self, ...}: {
  flake.homeModules.lang-all = {pkgs, ...}: {
    imports = [
      self.homeModules.lang-c
      self.homeModules.lang-latex
      self.homeModules.lang-nix
      self.homeModules.lang-python
      self.homeModules.lang-rust
    ];
  };

  flake.homeModules.lang-c = {pkgs, ...}: {
    home.packages = with pkgs; [
      clang-tools
      cmake
      gcc
      gnumake
      ninja
    ];
  };

  flake.homeModules.lang-latex = {pkgs, ...}: {
    home.packages = with pkgs; [
      tectonic
      texlive.combined.scheme-full
    ];
  };

  flake.homeModules.lang-nix = {pkgs, ...}: {
    home.packages = with pkgs; [
      alejandra
      nil
      deadnix
    ];
  };

  flake.homeModules.lang-python = {pkgs, ...}: {
    home.packages = with pkgs; [
      black
      isort
      poetry
      python3
      ruff
      ruff-lsp
      yapf
    ];

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
  };

  flake.homeModules.lang-rust = {pkgs, ...}: {
    home.packages = with pkgs; [
      fenix.stable.toolchain
    ];
  };
}
