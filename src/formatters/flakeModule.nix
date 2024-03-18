{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem = {...}: {
    treefmt.config = {
      projectRootFile = "flake.nix";
      programs.alejandra.enable = true;
      programs.prettier.enable = true;
      programs.stylua.enable = true;
      settings.formatter = {
        alejandra.excludes = [
          "nvfetcher/generated.nix"
        ];
        prettier.excludes = [
          "nvfetcher/generated.json"
        ];
      };
    };
  };
}
