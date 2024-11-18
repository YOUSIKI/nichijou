# Configure git, gh (github cli), and gitui.
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
  username = config.snowfallorg.user.name;

  cfg = config.${namespace}.programs.terminal.git;
in {
  options.${namespace}.programs.terminal.git = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable git.";
    };

    userName = lib.mkOption {
      type = lib.types.str;
      default = config.${namespace}.users.${username}.name;
      description = "The name to configure git with.";
    };

    userEmail = lib.mkOption {
      type = lib.types.str;
      default = config.${namespace}.users.${username}.email;
      description = "The email to configure git with.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      inherit (cfg) userName userEmail;

      enable = true;
      package = pkgs.gitFull;

      lfs.enable = true;
      delta.enable = true;
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
        push = {
          autoSetRemote = true;
          default = "current";
          followTags = true;
        };
        rebase.autoStash = true;
      };
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      extensions = with pkgs; [
        gh-actions-cache # cache actions
        gh-cal # contributions calender terminal viewer
        gh-copilot # github copilot integration
        gh-dash # dashboard with pull requests and issues
        gh-eco # explore the ecosystem
        gh-markdown-preview # preview markdown files
        gh-poi # clean up local branches safely
      ];
    };

    programs.gitui = {
      enable = true;
    };
  };
}
