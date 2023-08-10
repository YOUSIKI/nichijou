{pkgs, ...}: {
  # Used to find the project root
  projectRootFile = "flake.nix";
  # Enable the alejandra formatter for nix
  programs.alejandra.enable = true;
}
