{
  inputs,
  cell,
}: let
  l = inputs.nixpkgs.lib // builtins;

  hostConfigurations =
    l.mapAttrs
    (
      name: value: {
        imports = [value];

        deployment = {
          targetHost = name;
          targetPort = 22;
          targetUser = "yousiki";
        };
      }
    )
    cell.nixosConfigurations;
in
  hostConfigurations
