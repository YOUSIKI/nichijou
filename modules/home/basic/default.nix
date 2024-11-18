# This module is enabled by all home-manager configurations.
{
  lib,
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
