{pkgs, ...}: {
  home.packages = with pkgs; [
    tectonic
    tex-fmt
    texliveFull
  ];
}
