{
  inputs,
  cell,
}: let
  inherit (inputs.std) lib std;
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
      nixago = with cell.configs; [
        nvfetcher
        treefmt
      ];

      commands = [
        {
          name = "fetch";
          help = "Fetch latest sources with nvfetcher";
          command = ''
            nvfetcher -c nvfetcher.toml -o nvfetcher
            treefmt nvfetcher/*.nix
            treefmt nvfetcher/*.json
          '';
        }
      ];
    };
  }
