# Another Clash Kernel.
# Note that pkgs.*.overrideAttrs doesn't support buildGoModule
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/networking/clash-meta/default.nix
{
  pkgs,
  sources,
  ...
}:
if pkgs ? clash-meta
then
  pkgs.buildGoModule rec {
    inherit (sources.clash-meta) pname src;

    version = pkgs.lib.removePrefix "v" sources.clash-meta.version;

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

    meta = with pkgs.lib; {
      description = "Another Clash Kernel";
      homepage = "https://github.com/MetaCubeX/mihomo";
      changelog = "https://github.com/MetaCubeX/mihomo/releases/tag/${version}";
      mainProgram = "clash-meta";
      license = licenses.gpl3Only;
      maintainers = with maintainers; [yousiki];
    };
  }
else null
