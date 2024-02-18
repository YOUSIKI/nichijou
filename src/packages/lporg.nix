{
  globals,
  config,
  self',
  inputs',
  pkgs,
  system,
  ...
}: let
  recipe = {
    lib,
    stdenv,
    buildGoModule,
    fetchFromGitHub,
    installShellFiles,
    sources,
    platforms,
  }:
    buildGoModule rec {
      inherit (sources.lporg) pname version src;

      vendorHash = "sha256-GQaIfUtM3iDQ9jmrSMqYvcPysigdu7w10xGDIYv4OY8=";

      ldflags = [
        "-s"
        "-w"
        "-X github.com/blacktop/lporg/constant.Version=${version}"
      ];

      # disable check phase
      checkPhase = '''';

      meta = with lib; {
        description = "Organize Your macOS Launchpad Apps";
        longDescription = ''
          lporg is meant to help people setting up a brand
          new Mac or to keep all of their Launchpad Folders
          in sync across devices.
        '';
        homepage = "https://github.com/blacktop/lporg";
        changelog = "https://github.com/blacktop/lporg/releases/tag/${version}";
        license = with licenses; [mit];
        maintainers = with maintainers; [yousiki];
        mainProgram = "lporg";
        inherit platforms;
      };
    };

  sources = pkgs.callPackage (globals.root + /_sources/generated.nix) {};

  platforms =
    builtins.filter
    (pkgs.lib.hasSuffix "-darwin")
    (import globals.inputs.default-systems);

  package = pkgs.callPackage recipe {inherit sources platforms;};
in
  if builtins.elem system platforms
  then package
  else null
