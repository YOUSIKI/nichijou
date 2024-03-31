# project. It solves the vital problem of, "works on my machine."
{
  inputs,
  cell,
}: {
  default = inputs.std.lib.dev.mkShell {
    name = "nichijou";

    imports = [
      inputs.std.std.devshellProfiles.default
    ];

    packages = [
      (inputs.nixpkgs.extend inputs.nvfetcher.overlays.default).nvfetcher
    ];

    nixago = [
      cell.configs.treefmt
    ];

    commands = [
      {
        name = "fetch";
        help = "Fetch latest sources with nvfetcher";
        command = "nvfetcher -o nvfetcher";
      }
      {
        name = "fmt";
        help = "Format code with treefmt";
        command = "treefmt";
      }
      {
        name = "cache-x86_64-linux";
        help = "Build and push to cachix (x86_64-linux)";
        command = ''
          nix build --print-out-paths .#devShells.x86_64-linux.default | cachix push nichijou && \
          nix build --print-out-paths .#packages.x86_64-linux.clash-meta | cachix push nichijou && \
          nix build --print-out-paths .#packages.x86_64-linux.cloudflare-warp | cachix push nichijou && \
          nix build --print-out-paths .#nixosConfigurations.hakase.config.system.build.toplevel | cachix push nichijou
        '';
      }
      {
        name = "cache-x86_64-darwin";
        help = "Build and push to cachix (x86_64-darwin)";
        command = ''
          nix build --print-out-paths .#devShells.x86_64-darwin.default | cachix push nichijou && \
          nix build --print-out-paths .#packages.x86_64-linux.clash-meta | cachix push nichijou && \
          nix build --print-out-paths .#packages.x86_64-linux.lporg | cachix push nichijou && \
          nix build --print-out-paths .#darwinConfigurations.sakamoto.config.system.build.toplevel | cachix push nichijou
        '';
      }
    ];
  };
}
