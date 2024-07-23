{
  inputs,
  cell,
}: {
  pkgs,
  config,
  ...
}: {
  networking.proxy.default = "http://127.0.0.1:7890";
  networking.proxy.noProxy = "127.0.0.1,localhost,siki.moe,yousiki.top,ybh1998.space,edu.cn";

  services.cloudflare-warp.enable = true;

  services.mihomo = {
    enable = true;
    configFile = config.age.secrets.clash-config.path;
  };

  age.secrets.clash-config.file = "${inputs.self}/secrets/clash-config.yaml.age";
}
