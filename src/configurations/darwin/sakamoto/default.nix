# Configuration for sakamoto.
{globals, ...}:
globals.inputs.darwin.lib.darwinSystem {
  system = "x86_64-darwin";
  specialArgs = {inherit globals;};
  modules =
    [
      ./_applications.nix
      ./_configuration.nix

      globals.inputs.home-manager.darwinModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {inherit globals;};
          users.yousiki = {
            imports = with globals.outputs.homeProfiles; [
              base
              lang.complete
              shell
              ssh
            ];
          };
        };
      }
    ]
    ++ (with globals.outputs.commonProfiles; [
      nix
      packages
    ])
    ++ (with globals.outputs.darwinProfiles; [
      homebrew
    ]);
}
