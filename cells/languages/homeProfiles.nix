{
  inputs,
  cell,
}: let
  inherit (inputs.cells.repo.lib) importModule;
in {
  c = importModule ./home-c.nix;
  latex = importModule ./home-latex.nix;
  nix = importModule ./home-nix.nix;
  javascript = importModule ./home-javascript.nix;
  python = importModule ./home-python.nix;
  rust = importModule ./home-rust.nix;
}
