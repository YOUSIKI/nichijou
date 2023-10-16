{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      noto-fonts-lgc-plus
      sarasa-gothic
      source-han-mono
      source-han-sans
      source-han-serif
      twemoji-color-font
    ];
  };
}
