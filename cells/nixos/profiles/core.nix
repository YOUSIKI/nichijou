{
  inputs,
  cell,
}: {pkgs, ...}: {
  imports = [
    inputs.cells.common.commonProfiles.core
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
    autoPrune.enable = true;
    dockerSocket.enable = true;
  };

  system.stateVersion = "24.05";
}
