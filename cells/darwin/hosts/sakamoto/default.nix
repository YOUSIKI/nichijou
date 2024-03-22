{
  inputs,
  cell,
}: {
  _module.specialArgs = {
    inherit inputs;
  };

  imports = [
    ./applications.nix
    ./configuration.nix

    inputs.cells.darwin.darwinProfiles.core
    inputs.cells.darwin.darwinProfiles.homebrew

    inputs.cells.home.homeProfiles.base

    {
      home-manager.users.yousiki = {
        imports = [
          inputs.cells.home.homeProfiles.catppuccin
          inputs.cells.home.homeProfiles.core
          inputs.cells.home.homeProfiles.languages
          inputs.cells.home.homeProfiles.shell
          inputs.cells.home.homeProfiles.ssh
        ];

        bee.home-languages = [
          "c"
          "latex"
          "nix"
          "python"
          "rust"
        ];

        bee.home-catppuccin.flavor = "mocha";
      };
    }
  ];

  bee = rec {
    system = "x86_64-darwin";
    darwin = inputs.darwin;
    home = inputs.home-manager;
    pkgs = import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        cudaSupport = true;
      };
      overlays = [
        inputs.fenix.overlays.default
        inputs.nvfetcher.overlays.default
      ];
    };
  };
}
