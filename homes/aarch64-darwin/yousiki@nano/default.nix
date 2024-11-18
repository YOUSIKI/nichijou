{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  # An instance of `pkgs` with your overlays and packages applied is also available.
  # You also have access to your flake's inputs.
  # Additional metadata is provided by Snowfall Lib. # The namespace used for your flake, defaulting to "internal" if not set. # The home architecture for this host (eg. `x86_64-linux`). # The Snowfall Lib target for this home (eg. `x86_64-home`). # A normalized name for the home target (eg. `home`). # A boolean to determine whether this home is a virtual target using nixos-generators. # The host name for this home.
  # All other arguments come from the home.
  ...
}: {
  nichijou = {
    suites = {
      common.enable = true;
      desktop.enable = true;
    };

    themes.catppuccin.enable = true;
  };
}
