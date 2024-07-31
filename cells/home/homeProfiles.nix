{
  inputs,
  cell,
}: let
  inherit (inputs.cells.repo.lib) importModule;
in {
  # Common configuration for home-manager
  common = importModule ./common.nix;

  # Setup catppuccin theme
  catppuccin = importModule ./catppuccin.nix;

  # Setup programming languages
  languages = importModule ./languages.nix;

  # Setup shell
  shell = importModule ./shell.nix;

  # Setup ssh
  ssh = importModule ./ssh.nix;

  # Configure wezterm
  wezterm = importModule ./wezterm.nix;
}
