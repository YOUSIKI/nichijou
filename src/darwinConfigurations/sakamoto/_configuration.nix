{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.hostName = "sakamoto";
  networking.computerName = "YouSiki MacBookPro";

  users.users.yousiki = {
    name = "yousiki";
    home = "/Users/yousiki";
  };
}
