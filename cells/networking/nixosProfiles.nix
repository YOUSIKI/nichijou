{
  inputs,
  cell,
}: {
  # Setup system proxy via clash
  proxy = {
    config,
    pkgs,
    lib,
    ...
  }: {
    networking.proxy.default = "http://127.0.0.1:7890";
    networking.proxy.noProxy = "127.0.0.1,localhost,siki.moe,yousiki.top,ybh1998.space,edu.cn";
    networking.firewall.allowedTCPPorts = [
      7890
      7891
    ];
    services.mihomo = {
      enable = true;
      configFile = config.age.secrets.clash-config.path;
    };
    age.secrets.clash-config.file = "${inputs.self}/secrets/clash-config.yaml.age";
  };
}
