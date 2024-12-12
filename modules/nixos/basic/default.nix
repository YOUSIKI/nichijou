{
  lib,
  pkgs,
  system,
  ...
}: {
  imports = [
    (lib.snowfall.fs.get-file
      "modules/common/nix/default.nix")
    (lib.snowfall.fs.get-file
      "modules/common/packages/default.nix")
  ];

  # Default user shell: zsh
  users.defaultUserShell = pkgs.zsh;

  # Home-manager automatically backup extension.
  home-manager.backupFileExtension = "bak";

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = "24.11";

  # Use sudo without password.
  security.sudo.wheelNeedsPassword = false;

  # Enable ssh server.
  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  # Enable VSCode server.
  services.vscode-server = {
    enable = true;
    enableFHS = true;
    installPath = "$HOME/.windsurf-server";
  };

  # Enable nix-ld.
  programs.nix-ld.dev.enable = true;

  # Set timezone.
  time.timeZone = "Asia/Shanghai";
}
