{
  config,
  pkgs,
  lib,
  ...
}: {
  users.users.yousiki = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  time.timeZone = "Asia/Shanghai";
  services.openssh.enable = true;
  services.openssh.openFirewall = true;
  security.sudo.wheelNeedsPassword = false;
  system.stateVersion = "24.05";
}
