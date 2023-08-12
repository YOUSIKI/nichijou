{
  inputs,
  cell,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // inputs.nixpkgs.lib; {
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    nerdfonts
  ];
}
