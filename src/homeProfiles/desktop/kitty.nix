{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "CaskaydiaCove Nerd Font Propo";
      font_size = 12;
      tab_bar_min_tabs = 1;
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else '''}";
    };
    keybindings = {};
    environment = {};
    shellIntegration = {
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    theme = "Catppuccin-Mocha";
  };
}
