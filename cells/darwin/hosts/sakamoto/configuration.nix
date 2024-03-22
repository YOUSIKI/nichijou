{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.hostName = "sakamoto";
  networking.computerName = "YouSikiMacBookPro";

  users.users.yousiki = {
    name = "yousiki";
    home = "/Users/yousiki";
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # System configurations
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.dock.show-recents = false;
  system.defaults.dock.tilesize = 48;
  system.defaults.finder.QuitMenuItem = true;
  system.defaults.finder.ShowPathbar = true;
  system.defaults.finder.ShowStatusBar = true;
  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;
}
