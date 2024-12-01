{
  lib,
  config,
  pkgs,
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

  home = {
    # Configure environment variables.
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];

    # Set home-manager state version.
    stateVersion = "24.11";

    # TODO: remove after home-manager 25.05
    enableNixpkgsReleaseCheck = false;
  };

  # Enable vscode server on NixOS
  services.vscode-server.enable = pkgs.stdenv.isLinux;
}
