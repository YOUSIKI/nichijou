{
  pkgs,
  buildFHSUserEnv,
  ...
}:
buildFHSUserEnv {
  name = "micromamba-env";

  targetPkgs = _: [
    pkgs.micromamba
  ];

  profile = ''
    set -e
    eval "$(micromamba shell hook --shell=posix)"
    export MAMBA_ROOT_PREFIX=$HOME/micromamba
    set +e
  '';
}
