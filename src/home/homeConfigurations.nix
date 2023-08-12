{
  inputs,
  cell,
  ...
}:
with builtins // inputs.nixpkgs.lib; let
  inherit (inputs) haumea;

  userConfigurations =
    if pathExists ./users
    then
      haumea.lib.load {
        src = ./users;
        inputs = {inherit inputs cell;};
        transformer = haumea.lib.transformers.liftDefault;
      }
    else {};

  hostConfigurations =
    if pathExists ./hosts
    then
      haumea.lib.load {
        src = ./hosts;
        inputs = {inherit inputs cell;};
        transformer = haumea.lib.transformers.liftDefault;
      }
    else {};
in
  inputs.cells.utils.lib.mkHomeConfigurations
  userConfigurations
  hostConfigurations
