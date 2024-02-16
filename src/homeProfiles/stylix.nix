# Stylix configuration via Home-manager.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}:
with builtins // lib; {
  imports = [
    globals.inputs.stylix.homeManagerModules.stylix
  ];

  stylix = {
    image = "${globals.root}/static/images/AyanamiRei_2.png";

    base16Scheme = "${globals.inputs.schemes}/base16/catppuccin-mocha.yaml";
  };
}
