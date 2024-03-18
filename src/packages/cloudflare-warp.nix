# Another Clash Kernel.
# Note that pkgs.*.overrideAttrs doesn't support buildGoModule
# https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/networking/clash-meta/default.nix
{
  pkgs,
  sources,
  ...
}: let
  recipe = {
    stdenv,
    lib,
    fetchurl,
    dpkg,
    autoPatchelfHook,
    makeWrapper,
    copyDesktopItems,
    makeDesktopItem,
    dbus,
    nftables,
    cairo,
    gtk3,
    libpcap,
    ...
  }:
    stdenv.mkDerivation rec {
      pname = "cloudflare-warp";
      version = "2024.2.62";

      src = fetchurl {
        url = "https://pkg.cloudflareclient.com/pool/jammy/main/c/cloudflare-warp/cloudflare-warp_2024.2.62-1_amd64.deb";
        hash = "sha256-pq5sqAQu3UGEjj7fKctUN/JgJa/XzitCC7kEanHw0ug=";
      };

      nativeBuildInputs = [
        dpkg
        autoPatchelfHook
        makeWrapper
        copyDesktopItems
      ];

      buildInputs = [
        dbus
        stdenv.cc.cc.lib
        cairo
        gtk3
        libpcap
      ];

      desktopItems = [
        (makeDesktopItem {
          name = "com.cloudflare.WarpCli";
          desktopName = "Cloudflare Zero Trust Team Enrollment";
          categories = ["Utility" "Security" "ConsoleOnly"];
          noDisplay = true;
          mimeTypes = ["x-scheme-handler/com.cloudflare.warp"];
          exec = "warp-cli teams-enroll-token %u";
          startupNotify = false;
          terminal = true;
        })
      ];

      autoPatchelfIgnoreMissingDeps = [
        "libpcap.so.0.8"
      ];

      installPhase = ''
        runHook preInstall

        mv usr $out
        mv bin $out
        mv etc $out
        mv lib/systemd/system $out/lib/systemd/
        substituteInPlace $out/lib/systemd/system/warp-svc.service \
          --replace "ExecStart=" "ExecStart=$out"
        substituteInPlace $out/lib/systemd/user/warp-taskbar.service \
          --replace "ExecStart=" "ExecStart=$out"

        runHook postInstall
      '';

      postInstall = ''
        wrapProgram $out/bin/warp-svc --prefix PATH : ${lib.makeBinPath [nftables]}
      '';

      meta = with lib; {
        description = "Replaces the connection between your device and the Internet with a modern, optimized, protocol";
        homepage = "https://pkg.cloudflareclient.com/packages/cloudflare-warp";
        sourceProvenance = with sourceTypes; [binaryNativeCode];
        license = licenses.unfree;
        maintainers = with maintainers; [yousiki];
        platforms = ["x86_64-linux"];
      };
    };
in
  if pkgs.system == "x86_64-linux"
  then pkgs.callPackage recipe {}
  else null
