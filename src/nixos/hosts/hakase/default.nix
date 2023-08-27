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
    packages = [];
    shell = nixpkgs.zsh;
  };

  environment.systemPackages = with nixpkgs; [
    cloudflare-warp
  ];

  imports = [
    ./_hardware-configuration.nix

    cell.nixosProfiles.base
    cell.nixosProfiles.fonts
    cell.nixosProfiles.nvidia
    cell.nixosProfiles.virtualisation
    cell.nixosProfiles.vscode-server

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.yousiki = _: {
        imports = [
          inputs.cells.home.homeConfigurations."yousiki@hakase"
        ];
      };
    }
  ];
}
