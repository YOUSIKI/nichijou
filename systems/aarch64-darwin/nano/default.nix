{
  # Snowfall Lib provides a customized `lib` instance with access to your flake's library
  # as well as the libraries available from your flake's inputs.
  # An instance of `pkgs` with your overlays and packages applied is also available.
  pkgs,
  # You also have access to your flake's inputs.
  # Additional metadata is provided by Snowfall Lib. # The namespace used for your flake, defaulting to "internal" if not set. # The system architecture for this host (eg. `x86_64-linux`). # The Snowfall Lib target for this system (eg. `x86_64-iso`). # A normalized name for the system target (eg. `iso`). # A boolean to determine whether this system is a virtual target using nixos-generators. # An attribute map of your defined hosts.
  # All other arguments come from the system system.
  ...
}: {
  # Your configuration.
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    alejandra
  ];
}
