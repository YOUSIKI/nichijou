{
  inputs,
  cell,
  ...
}: {
  bee.system = "x86_64-darwin";

  networking.hostName = "sakamoto";
  networking.computerName = "YouSiki MacBook Pro";

  imports = [
    cell.darwinProfiles.base
    cell.darwinProfiles.fonts
    cell.darwinProfiles.homebrew
  ];
}
