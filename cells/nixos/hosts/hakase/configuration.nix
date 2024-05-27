# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "hakase";

  services.cloudflared = {
    enable = true;
    tunnels = {
      "hakase-tunnel" = {
        credentialsFile = "${config.age.secrets.hakase-tunnel-cert.path}";
        ingress = {
          "nas.siki.moe" = "http://satoshi.siki.moe:5000";
          "plex.siki.moe" = "http://localhost:32400";
          "qb.siki.moe" = "http://localhost:8080";
        };
        default = "http_status:404";
      };
    };
  };

  services.qbittorrent = {
    enable = true;
    webui.port = 8080;
  };

  services.plex = {
    enable = true;
    openFirewall = true;
  };
}
