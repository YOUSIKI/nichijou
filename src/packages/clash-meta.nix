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
    fetchFromGitHub,
    buildGoModule,
    sources,
    platforms,
  }:
    buildGoModule rec {
      inherit (sources.clash-meta) pname version src;

      vendorHash = "sha256-tvPR5kAta4MlMTwjfxwVOacRr2nVpfalbN08mfxml64=";

      # Do not build testing suit
      excludedPackages = ["./test"];

      ldflags = [
        "-s"
        "-w"
        "-X github.com/MetaCubeX/mihomo/constant.Version=${version}"
      ];

      tags = [
        "with_gvisor"
      ];

      # network required
      doCheck = false;

      postInstall = ''
        mv $out/bin/mihomo $out/bin/clash-meta
      '';

      meta = with lib; {
        description = "Another Clash Kernel";
        homepage = "https://github.com/MetaCubeX/mihomo";
        changelog = "https://github.com/MetaCubeX/mihomo/releases/tag/${version}";
        license = licenses.gpl3Only;
        maintainers = with maintainers; [yousiki];
        mainProgram = "clash-meta";
        inherit platforms;
      };
    };

  sources = pkgs.callPackage (globals.root + /_sources/generated.nix) {};

  platforms = import globals.inputs.default-systems;

  package = pkgs.callPackage recipe {inherit sources platforms;};
in
  if builtins.elem system platforms
  then package
  else null
