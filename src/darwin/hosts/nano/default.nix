{
  inputs,
  cell,
  ...
}: {
  bee.system = "aarch64-darwin";

  networking.hostName = "nano";
  networking.computerName = "YouSiki MacBookPro";

  imports = [
    cell.darwinProfiles.base
    cell.darwinProfiles.fonts
    cell.darwinProfiles.homebrew
  ];
}
