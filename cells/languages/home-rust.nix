{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    rustup
  ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
