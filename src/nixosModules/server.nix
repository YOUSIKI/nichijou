{inputs, ...} @ args: {...}: {
  imports = [
    inputs.nixos-vscode-server.nixosModules.default
  ];

  # Fix vscode server issue.
  services.vscode-server.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.openFirewall = true;

  # Enable the firewall.
  networking.firewall.enable = true;
}
