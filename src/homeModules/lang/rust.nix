{...} @ args: {pkgs, ...}: {
  home.packages = with pkgs; [
    fenix.stable.toolchain
  ];
}
