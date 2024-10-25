{pkgs, ...}: {
  home.packages = with pkgs; [
    nodejs
    pnpm
    yarn-berry
  ];
}
