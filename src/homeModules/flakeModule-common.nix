{...}: {
  flake.homeModules.common = {
    pkgs,
    config,
    ...
  }: {
    # Specify home directory.
    home.homeDirectory = pkgs.lib.mkDefault (
      if pkgs.stdenv.isDarwin
      then "/Users/${config.home.username}"
      else "/home/${config.home.username}"
    );

    # Configure state version.
    home.stateVersion = "23.05";
  };
}
