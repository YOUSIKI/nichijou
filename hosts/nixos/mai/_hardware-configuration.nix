{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
with builtins // lib; {
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "vmd" "xhci_pci" "ahci" "nvme" "usbhid" "uas" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/fea71ca7-5cd4-4db1-9d0a-77d7da09d524";
      fsType = "btrfs";
      options = ["compress=zstd"];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/C7B6-BA1F";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/07c85597-9372-41c7-88af-438195c83fb0"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = mkDefault true;
  # networking.interfaces.eno1.useDHCP = mkDefault true;

  nixpkgs.hostPlatform = mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = mkDefault "performance";
  hardware.cpu.intel.updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;
}