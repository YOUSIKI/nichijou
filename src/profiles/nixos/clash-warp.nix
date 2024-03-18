# Configure clash-warp for NixOS.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    globals.inputs.arion.nixosModules.arion
  ];

  virtualisation.arion = {
    backend = "docker";
    projects.clash-warp = {
      serviceName = "clash-warp";
      settings = {
        project.name = "clash-warp";
        services = {
          clash = {
            image.enableRecommendedContents = true;
            service.useHostStore = true;
            service.ports = [
              "7890:7890"
            ];
            service.command = [
              ''${pkgs.clash-meta}/bin/clash-meta''
            ];
          };
          warp = {
            image.enableRecommendedContents = true;
            service.useHostStore = true;
            service.ports = [
              "40000:40000"
            ];
            service.command = [
              ''${pkgs.cloudflare-warp}/bin/warp-svc''
            ];
            service.capabilities = {
              NET_ADMIN = true;
            };
            service.sysctls = {
              "net.ipv6.conf.all.disable_ipv6" = 0;
              "net.ipv4.conf.all.src_valid_mark" = 1;
            };
            service.volumes = [
              # "/home/yousiki/Documents/nichijou/static/cloudflare_warp_data/config.json:/var/lib/cloudflare-warp/config.json:ro"
              # "/home/yousiki/Documents/nichijou/static/cloudflare_warp_data/settings.json:/var/lib/cloudflare-warp/settings.json:ro"
              # "${config.sops.secrets."cloudflare-warp-config.json".path}:/var/lib/cloudflare-warp/config.json:ro"
              # "${config.sops.secrets.cloudflare-warp-settings.path}:/var/lib/cloudflare-warp/settings.json:ro"
            ];
          };
        };
      };
    };
  };
}
