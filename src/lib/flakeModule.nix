# Adapted from https://github.com/srid/nixos-flake/blob/master/flake-module.nix
{
  self,
  inputs,
  config,
  ...
}: let
  specialArgs = rec {
    flake = self;
    flakeInputs = inputs;
    flakeConfig = config;
  };
in {
  config = {
    flake = {
      # Linux home-manager module
      nixosModules.home-manager = {
        imports = [
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
          }
        ];
      };

      # macOS home-manager module
      darwinModules.home-manager = {
        imports = [
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = specialArgs;
          }
        ];
      };

      lib = rec {
        inherit specialArgs;

        mkLinuxSystem = mod:
          inputs.nixpkgs.lib.nixosSystem {
            specialArgs = specialArgs;
            modules = [mod];
          };

        mkMacosSystem = mod:
          inputs.nix-darwin.lib.darwinSystem {
            specialArgs = specialArgs;
            modules = [mod];
          };

        mkHomeConfiguration = pkgs: mod:
          inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = specialArgs;
            modules = [mod];
          };
      };
    };
  };
}
