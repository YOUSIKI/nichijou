{
  config,
  self',
  inputs',
  pkgs,
  system,
  flake,
  ...
}: {
  config = {
    inherit (config.flake-root) projectRootFile;
    package = pkgs.treefmt;
    programs.alejandra.enable = true;
    programs.prettier.enable = true;
    programs.stylua.enable = true;
  };
}
