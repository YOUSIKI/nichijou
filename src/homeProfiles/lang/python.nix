{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; let
  installationPath = "~/.miniconda";
in {
  home.packages =
    (with pkgs; [
      black
      isort
      poetry
      python3
      ruff
      ruff-lsp
    ])
    ++ (optionals pkgs.stdenv.isLinux (with globals.outputs.packages.${pkgs.system}; [
      miniconda
    ]));

  programs.bash.initExtra = ''
    # Add conda to PATH
    export PATH=${installationPath}/bin:$PATH
    # Paths for gcc if compiling some C sources with pip
    export NIX_CFLAGS_COMPILE="-I${installationPath}/include"
    export NIX_CFLAGS_LINK="-L${installationPath}lib"
    # Some other required environment variables
    export FONTCONFIG_FILE=/etc/fonts/fonts.conf
    export QTCOMPOSE=${pkgs.xorg.libX11}/share/X11/locale
    export LIBARCHIVE=${pkgs.libarchive.lib}/lib/libarchive.so
    # Allows `conda activate` to work properly if already installed
    if [ -d ${installationPath}/etc/profile.d ]; then
      source ${installationPath}/etc/profile.d/conda.sh
    fi
  '';

  programs.zsh.initExtra = ''
    # Add conda to PATH
    export PATH=${installationPath}/bin:$PATH
    # Paths for gcc if compiling some C sources with pip
    export NIX_CFLAGS_COMPILE="-I${installationPath}/include"
    export NIX_CFLAGS_LINK="-L${installationPath}lib"
    # Some other required environment variables
    export FONTCONFIG_FILE=/etc/fonts/fonts.conf
    export QTCOMPOSE=${pkgs.xorg.libX11}/share/X11/locale
    export LIBARCHIVE=${pkgs.libarchive.lib}/lib/libarchive.so
    # Allows `conda activate` to work properly if already installed
    if [ -d ${installationPath}/etc/profile.d ]; then
      source ${installationPath}/etc/profile.d/conda.sh
    fi
  '';

  xdg.configFile."pip/pip.conf".source = globals.root + /static/configs/pip/pip.conf;

  home.file.".condarc".source = globals.root + /static/configs/conda/condarc;
}
