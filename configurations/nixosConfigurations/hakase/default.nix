# NixOS configuration for hakase
{global, ...}: let
  nixosProfiles = with global.outputs.nixosProfiles; [
    applications
    base
    fonts
    nvidia
    virtualisation
    vscode-server
  ];

  homeProfiles = with global.outputs.homeProfiles; [
    base
    lang.c
    lang.nix
    lang.python
    lang.rust
    shell
  ];

  modules =
    [
      ./_configuration.nix
      ./_hardware-configuration.nix
    ]
    ++ nixosProfiles
    ++ [
      global.inputs.home-manager.nixosModules.home-manager
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
  global.inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit global;};
    modules = modules;
  }
