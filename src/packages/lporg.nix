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
    sources ? {},
  }:
    buildGoModule rec {
      inherit (sources.lporg) pname version src;

      vendorHash = "sha256-GQaIfUtM3iDQ9jmrSMqYvcPysigdu7w10xGDIYv4OY8=";

      nativeBuildInputs = [
        installShellFiles
      ];

      checkPhase = '''';

      postInstall = '''';

      meta = with lib; {
        description = "Organize Your macOS Launchpad Apps";
        longDescription = ''
          lporg is meant to help people setting up a brand
          new Mac or to keep all of their Launchpad Folders
          in sync across devices.
        '';
        homepage = "https://github.com/blacktop/lporg";
        changelog = "https://github.com/blacktop/lporg/releases/tag/v${version}";
        license = with licenses; [mit];
        maintainers = with maintainers; [yousiki];
      };
    };

  sources = pkgs.callPackage (globals.root + /_sources/generated.nix) {};

  package = pkgs.callPackage recipe {inherit sources;};

  systems =
    builtins.filter
    (system: pkgs.lib.hasSuffix "-darwin" system)
    (import globals.inputs.default-systems);
in
  if builtins.elem system systems
  then package
  else null
