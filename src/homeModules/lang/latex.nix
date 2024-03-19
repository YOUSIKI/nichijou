{...} @ args: {pkgs, ...}: {
  home.packages = with pkgs; [
    tectonic
    texlive.combined.scheme-full
  ];
}
