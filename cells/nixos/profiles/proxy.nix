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
  ];

  networking.proxy.default = "http://127.0.0.1:7890";
  networking.proxy.noProxy = "127.0.0.1,localhost,yousiki.top,siki.moe,edu.cn";

  services.cloudflare-warp.enable = true;

  services.clash-meta.enable = true;
  services.clash-meta.configPath = config.age.secrets.clash-config.path;
  services.clash-meta.openFirewall = true;

  age.secrets.clash-config.file = "${inputs.self}/secrets/clash-config.yaml.age";
}
