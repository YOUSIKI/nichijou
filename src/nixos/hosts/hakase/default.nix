{
  inputs,
  cell,
  ...
}: let
  inherit (inputs) nixpkgs;
in {
  bee.system = "x86_64-linux";

  networking.hostName = "hakase";

  services.autosuspend.enable = false;

  boot.kernelPackages = nixpkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver = {
    layout = "cn";
    xkbVariant = "";
  };
  programs.xwayland.enable = true;

  users.users.yousiki = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "yousiki"];
    packages = with nixpkgs; [];
    shell = nixpkgs.zsh;
  };

  imports = [
    ./_hardware-configuration.nix

    cell.nixosProfiles.base
    cell.nixosProfiles.clash
    cell.nixosProfiles.fonts
    cell.nixosProfiles.nvidia
    cell.nixosProfiles.virtualisation
    cell.nixosProfiles.vscode-server
  ];
}
