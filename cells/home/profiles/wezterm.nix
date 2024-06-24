{
  inputs,
  cell,
}: {
  config,
  pkgs,
  lib,
  ...
}: let
  l = builtins // lib;

  weztermConfig = ''
    local wezterm = require 'wezterm'

    local config = {}

    if wezterm.config_builder then
      config = wezterm.config_builder()
    end

    config.color_scheme = 'Catppuccin Mocha'

    config.font = wezterm.font_with_fallback {
      'CaskaydiaCove Nerd Font',
      'Jetbrains Nerd Font',
      'Fira Code',
      'Source Code Pro',
    }

    config.font_size = 13.0

    return config
  '';
in {
  home.file.".config/wezterm/wezterm.lua".text = weztermConfig;
}
