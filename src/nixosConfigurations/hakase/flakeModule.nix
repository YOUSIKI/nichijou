{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.hakase = self.lib.mkLinuxSystem {
    nixpkgs.hostPlatform = "x86_64-linux";

    imports = [
      ./configuration.nix
      ./hardware-configuration.nix

      inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
      inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
      inputs.nixos-hardware.nixosModules.common-pc-hdd
      inputs.nixos-hardware.nixosModules.common-pc-ssd

      self.commonModules.default

      self.nixosModules.common
      self.nixosModules.desktop
      self.nixosModules.nvidia
      self.nixosModules.server

      self.nixosModules.home-manager
      {
        home-manager.users.yousiki = {
          imports = [
            self.homeModules.catppuccin
            self.homeModules.common
            self.homeModules.lang-all
            self.homeModules.shell
          ];
        };
      }
    ];
  };
}
