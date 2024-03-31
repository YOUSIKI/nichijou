{
  pkgs,
  lib,
  sources,
}:
pkgs.buildGoModule rec {
  inherit (sources.clash-meta) pname src;

  version = lib.removePrefix "v" sources.clash-meta.version;

  vendorHash = "sha256-k4xB/jO78VGD+n9HtuoWXoXB+kZCEyPKJTTwj32nGIw=";

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
    mainProgram = "clash-meta";
    license = with licenses; [gpl3Only];
    maintainers = with maintainers; [yousiki];
  };
}
