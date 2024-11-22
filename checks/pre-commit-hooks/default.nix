{
  lib,
  inputs,
  system,
  ...
}:
inputs.pre-commit-hooks.lib.${system}.run {
  src = ./.;

  hooks = {
    actionlint.enable = true;

    deadnix = {
      enable = true;
      settings = {
        edit = true;
      };
    };

    statix.enable = true;

    luacheck.enable = true;

    pre-commit-hook-ensure-sops.enable = true;

    shfmt.enable = true;
  };
}
