# Configure used yousiki
{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  lib,
  # An instance of `pkgs` with your overlays and packages applied is also available.
  pkgs,
  # You also have access to your flake's inputs.
  inputs,
  # Additional metadata is provided by Snowfall Lib.
  namespace, # The namespace used for your flake, defaulting to "internal" if not set.
  system, # The system architecture for this host (eg. `x86_64-linux`).
  target, # The Snowfall Lib target for this system (eg. `x86_64-iso`).
  format, # A normalized name for the system target (eg. `iso`).
  virtual, # A boolean to determine whether this system is a virtual target using nixos-generators.
  systems, # An attribute map of your defined hosts.
  # All other arguments come from the module system.
  config,
  ...
}: let
  cfg = config.${namespace}.users.yousiki;
in {
  options.${namespace}.users.yousiki = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "YouSiki";
      description = "The name of the user yousiki.";
    };

    email = lib.mkOption {
      type = lib.types.str;
      default = "you.siki@outlook.com";
      description = "The email of the user yousiki.";
    };
  };

  config = {
    assertions = [
      {
        assertion = cfg.name != null;
        message = "${namespace}.users.yousiki.name must be set";
      }
      {
        assertion = cfg.email != null;
        message = "${namespace}.users.yousiki.email must be set";
      }
    ];

    home.username = lib.mkDefault cfg.name;
  };
}
