{
  inputs,
  cell,
}: {
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.cells.nixos.nixosModules.clash-meta
    inputs.cells.nixos.nixosModules.cloudflare-warp
  ];

  networking.proxy.default = "http://127.0.0.1:7890";
  networking.proxy.noProxy = "127.0.0.1,localhost,yousiki.top,edu.cn";

  services.cloudflare-warp.enable = true;
  services.cloudflare-warp.openFirewall = true;

  services.clash-meta.enable = true;
  services.clash-meta.configPath = config.age.secrets.clash-config.path;
  services.clash-meta.openFirewall = true;
}
