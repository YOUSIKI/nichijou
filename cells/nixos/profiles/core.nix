{
  inputs,
  cell,
}: {pkgs, ...}: {
  imports = [
    inputs.cells.common.commonProfiles.core
    inputs.agenix.nixosModules.default
  ];

  time.timeZone = "Asia/Shanghai";

  users.users.yousiki = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  services.openssh.enable = true;
  services.openssh.openFirewall = true;

  security.sudo.wheelNeedsPassword = false;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    autoPrune.enable = true;
    dockerSocket.enable = true;
  };

  virtualisation.containers.enable = true;

  environment.systemPackages = with pkgs; [
    docker-compose
    podman-compose
    inputs.cells.common.packages.clash-meta
    inputs.cells.nixos.packages.cloudflare-warp
  ];

  system.stateVersion = "24.05";
}
