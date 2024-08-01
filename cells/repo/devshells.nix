{
  inputs,
  cell,
}: let
  inherit (inputs.std) lib std;
  inherit (inputs.cells.repo.lib) localPkgs;
in
  builtins.mapAttrs (_: lib.dev.mkShell) {
    # Tool Homepage: https://numtide.github.io/devshell/
    default = {
      name = "nichijou";

      imports = [
        std.devshellProfiles.default
      ];

      # Tool Homepage: https://nix-community.github.io/nixago/
      # This is Standard's devshell integration.
      # It runs the startup hook when entering the shell.
      nixago = [
        cell.configs.treefmt
        inputs.cells.lporg.configs.nvfetcher
      ];

      packages = with localPkgs; [
        colmena
      ];

      commands = [
        {
          name = "fetch";
          help = "fetches the latest sources of packages";
          command = ''
            std //lporg/nvfetcher/lporg:fetch
          '';
        }
      ];
    };
  }
