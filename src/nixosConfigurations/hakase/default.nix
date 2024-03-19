{
  self,
  inputs,
  ...
}:
self.lib.mkLinuxSystem {
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

    self.lib.mkLinuxHomeModule
    {
      home-manager.users.yousiki = {
        imports = [
          self.homeModules.catppuccin
          self.homeModules.common
          self.homeModules.lang.c
          self.homeModules.lang.latex
          self.homeModules.lang.nix
          self.homeModules.lang.python
          self.homeModules.lang.rust
          self.homeModules.shell
        ];
      };
    }
  ];
}
