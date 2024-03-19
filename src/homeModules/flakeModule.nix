{...} @ args: {
  flake.homeModules = {
    catppuccin = import ./catppuccin.nix args;
    common = import ./common.nix args;
    lang = import ./lang args;
    shell = import ./shell.nix args;
  };
}
