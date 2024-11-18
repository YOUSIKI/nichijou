# Comma runs software without installing it.
# https://github.com/nix-community/comma
# This module also enables nix-index and nix-index-database.
{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  lib,
  # An instance of `pkgs` with your overlays and packages applied is also available.
  pkgs,
  # You also have access to your flake's inputs.
  # Additional metadata is provided by Snowfall Lib.
  namespace, # The namespace used for your flake, defaulting to "internal" if not set. # The system architecture for this host (eg. `x86_64-linux`). # The Snowfall Lib target for this system (eg. `x86_64-iso`). # A normalized name for the system target (eg. `iso`). # A boolean to determine whether this system is a virtual target using nixos-generators. # An attribute map of your defined hosts.
  # All other arguments come from the module system.
  config,
  ...
}: let
  cfg = config.${namespace}.programs.terminal.comma;
in {
  options.${namespace}.programs.terminal.comma = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable comma.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      nix-index-database.comma.enable = true;

      nix-index = {
        enable = true;
        package = pkgs.nix-index;

        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;

        # Symlink nix-index-database to ~/.cache/nix-index
        symlinkToCacheHome = true;
      };
    };
  };
}
