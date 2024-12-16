{
  lib,
  pkgs,
  namespace,
  config,
  ...
}: let
  cfg = config.${namespace}.languages.nix;
in {
  options.${namespace}.languages.nix = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable nix programming language.";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        alejandra
        cachix
        deadnix
        nil
        nixd
        statix
      ];
    };
  };
}
