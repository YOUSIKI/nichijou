{pkgs, ...}: {
  # Set the hostname and computer name
  networking.hostName = "nano";
  networking.computerName = "YouSiki's Nano";

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

  environment.systemPackages = with pkgs; [
    alejandra
    nodejs
  ];
}
