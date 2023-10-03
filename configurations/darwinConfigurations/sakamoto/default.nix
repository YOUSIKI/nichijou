# Nix-darwin configuration for sakamoto
{global, ...}: let
  darwinProfiles = with global.outputs.darwinProfiles; [
    applications
    base
    fonts
  ];

  homeProfiles = with global.outputs.homeProfiles; [
    base
    lang.nix
    lang.python
    lang.rust
    shell
  ];

  modules =
    [
      ./_configuration.nix
    ]
    ++ darwinProfiles
    ++ [
      global.inputs.home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {inherit global;};
        home-manager.users.yousiki = {
          imports = homeProfiles;
        };
      }
    ];
in
  global.inputs.darwin.lib.darwinSystem {
    system = "x86_64-darwin";
    specialArgs = {inherit global;};
    modules = modules;
  }
