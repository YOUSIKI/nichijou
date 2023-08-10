{
  inputs,
  cell,
  pkgs,
  config,
  ...
}: let
  inherit (inputs.nixpkgs-lib.lib) splitString;
  inherit (builtins) elem filter readFile;

  nerdfont-disabled-list = [
    "font-aurulent-sans-mono-nerd-font"
  ];

  nerdfont-cask-list =
    filter
    (x: x != "" && !elem x nerdfont-disabled-list)
    (splitString "\n" (readFile ./nerdfont-cask-list.txt));
in {
  homebrew.enable = true;

  homebrew.taps = [
    "homebrew/cask-fonts"
  ];

  homebrew.casks =
    [
      "font-cascadia-code-pl"
      "font-cascadia-code"
      "font-delugia-complete"
      "font-lxgw-wenkai"
      "font-source-code-pro-for-powerline"
      "font-source-code-pro"
    ]
    ++ nerdfont-cask-list;
}
