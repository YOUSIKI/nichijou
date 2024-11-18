# starship
{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  lib,
  # An instance of `pkgs` with your overlays and packages applied is also available.
  # You also have access to your flake's inputs.
  # Additional metadata is provided by Snowfall Lib.
  namespace, # The namespace used for your flake, defaulting to "internal" if not set. # The system architecture for this host (eg. `x86_64-linux`). # The Snowfall Lib target for this system (eg. `x86_64-iso`).
  format, # A normalized name for the system target (eg. `iso`). # A boolean to determine whether this system is a virtual target using nixos-generators. # An attribute map of your defined hosts.
  # All other arguments come from the module system.
  config,
  ...
}: let
  cfg = config.${namespace}.programs.terminal.starship;
in {
  options.${namespace}.programs.terminal.starship = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable starship.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableIonIntegration = true;
      enableNushellIntegration = true;
      enableTransience = true;
      settings.format = "$all";
    };
  };
}
