# Nix-darwin configuration for sakamoto
{flake, ...}:
flake.inputs.darwin.lib.darwinSystem {
  system = "x86_64-darwin";
  specialArgs = {inherit flake;};
  modules = [
    ./_configuration.nix

    flake.outputs.darwinProfiles.applications
    flake.outputs.darwinProfiles.base
    flake.outputs.darwinProfiles.fonts

    flake.inputs.home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {inherit flake;};
      home-manager.users.yousiki = {
        imports = [
          flake.outputs.homeProfiles.base
          flake.outputs.homeProfiles.cc
          flake.outputs.homeProfiles.python
          flake.outputs.homeProfiles.rust
          flake.outputs.homeProfiles.shell
        ];
      };
    }
  ];
}
