{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-vscode-server.nixosModules.default

    inputs.cells.common.nixosProfiles.nix
    inputs.cells.common.nixosProfiles.packages
    inputs.cells.common.nixosProfiles.home-manager
  ];

  # Set up users.
  users.users.yousiki = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    shell = pkgs.zsh;
  };

  programs = {
    # Enable nix-ld for better linking.
    nix-ld.enable = true;
    # Enable zsh.
    zsh.enable = true;
  };

  # Set timezone.
  time.timeZone = "Asia/Shanghai";

  services = {
    # Enable ssh server.
    openssh = {
      enable = true;
      openFirewall = true;
    };
    # Fix vscode server issue on NixOS.
    vscode-server.enable = true;
  };

  # Use sudo without password.
  security.sudo.wheelNeedsPassword = false;

  # Set NixOS state version.
  system.stateVersion = "24.05";
}
