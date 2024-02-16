{
  globals,
  config,
  self',
  inputs',
  pkgs,
  system,
  ...
}:
with builtins // pkgs.lib;
  pkgs.symlinkJoin {
    name = "nichijou-packages";
    paths =
      attrValues
      (filterAttrs
        (n: v: n != "default")
        globals.outputs.packages.${pkgs.system});
  }
