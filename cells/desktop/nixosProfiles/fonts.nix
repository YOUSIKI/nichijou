# Fonts for NixOS desktop.
{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      cascadia-code
      lxgw-neoxihei
      lxgw-wenkai
      monaspace
      nerdfonts
      noto-fonts-cjk
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      source-han-mono
      source-han-sans
      source-han-serif
      wqy_microhei
      wqy_zenhei
    ];
  };
}
