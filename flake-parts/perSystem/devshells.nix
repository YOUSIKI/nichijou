# Development environment
{
  config,
  self',
  inputs',
  pkgs,
  system,
  flake,
  ...
}: {
  default = {
    packages = with pkgs; [
      alejandra
      curl
      gh
      git
      helix
      vim
      wget
    ];
  };
}
