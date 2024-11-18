# This module is enabled by all home-manager configurations.
{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  lib,
  # An instance of `pkgs` with your overlays and packages applied is also available.
  # You also have access to your flake's inputs.
  # Additional metadata is provided by Snowfall Lib. # The namespace used for your flake, defaulting to "internal" if not set. # The system architecture for this host (eg. `x86_64-linux`). # The Snowfall Lib target for this system (eg. `x86_64-iso`). # A normalized name for the system target (eg. `iso`). # A boolean to determine whether this system is a virtual target using nixos-generators. # An attribute map of your defined hosts.
  # All other arguments come from the module system.
  config,
  ...
}: {
  # Whether to enable Home Manager.
  programs.home-manager.enable = true;

  # Whether to enable management of XDG base directories.
  xdg.enable = true;

  # Enable shells and let home-manager manage bashrc/zshrc.
  programs = {
    bash.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
  };

  # Configuare environment variables.
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];

  home.stateVersion = "24.11";

  # TODO: remove after home-manager 25.05
  home.enableNixpkgsReleaseCheck = false;
}
