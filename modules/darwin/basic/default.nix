{
  lib,
  inputs,
  system,
  ...
}: {
  imports = [
    (lib.snowfall.fs.get-file
      "modules/common/nix/default.nix")
    (lib.snowfall.fs.get-file
      "modules/common/packages/default.nix")
  ];

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Home-manager automatically backup extension.
  home-manager.backupFileExtension = "bak";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
