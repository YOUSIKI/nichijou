{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.hostName = "sakamoto";
  networking.computerName = "YouSiki MacBookPro";

  environment.systemPackages = with pkgs; [
  ];
}
