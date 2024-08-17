# Common configuration for desktop.
{cell, ...}: {
  imports = [
    # Import fonts.
    cell.nixosProfiles.fonts
    # Import graphical packages.
    cell.nixosProfiles.packages
  ];

  services = {
    xserver.enable = true;
    # Enable SDDM and Plasma 6.
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    # Enable audio.
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
  security.rtkit.enable = true;
}
