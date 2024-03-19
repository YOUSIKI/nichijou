{...} @ args: {pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    nil
    deadnix
  ];
}
