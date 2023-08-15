{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
with builtins // lib; {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["vmd" "xhci_pci" "ahci" "nvme" "uas" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/1ea8a865-e2c3-4435-8292-75cb1530a312";
    fsType = "btrfs";
    options = ["compress=zstd"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4988-1DDD";
    fsType = "vfat";
  };

  fileSystems."/mnt/ssd" = {
    device = "/dev/disk/by-uuid/11db0944-b7ae-4e84-8dbd-13de8537efd1";
    fsType = "btrfs";
    options = ["compress=zstd"];
  };

  fileSystems."/mnt/hdd" = {
    device = "/dev/disk/by-uuid/0c2264ed-46f9-4868-bab0-2efa61c7bb1f";
    fsType = "btrfs";
    options = ["compress=zstd"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/e7a60826-7f50-48a6-96a9-dceab983333f";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = mkDefault "performance";
  hardware.cpu.intel.updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;
}
