# treefmt.nix
{...}: {
  # Used to find the project root
  projectRootFile = "flake.nix";
  # Enable alejandra for nix
  programs.alejandra.enable = true;
  # Enable stylua for lua
  programs.stylua.enable = true;
}
