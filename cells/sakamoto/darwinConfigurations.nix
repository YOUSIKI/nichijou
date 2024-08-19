{
  inputs,
  cell,
}: {
  sakamoto = {
    bee = rec {
      system = "x86_64-darwin";
      darwin = inputs.darwin;
      home = inputs.home-manager-darwin;
      pkgs = import inputs.nixpkgs-darwin {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [
          inputs.agenix.overlays.default
        ];
      };
    };

    imports = [
      # Local modules.
      cell.darwinProfiles.configuration
      # Internal modules.
      inputs.cells.darwin.darwinProfiles.common
      inputs.cells.desktop.darwinProfiles.fonts
      inputs.cells.desktop.darwinProfiles.packages
      # Home modules.
      {
        home-manager.users.yousiki = {
          imports = [
            # External home modules.
            inputs.catppuccin.homeManagerModules.catppuccin
            # Internal home modules.
            inputs.cells.home.homeProfiles.common
            inputs.cells.home.homeProfiles.wezterm
            inputs.cells.languages.homeProfiles.common
          ];
        };
      }
    ];
  };
}
