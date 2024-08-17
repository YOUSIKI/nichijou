# Setup system proxy via clash.
{
  inputs,
  config,
  ...
}: {
  # Enable system proxy.
  networking.proxy.default = "http://127.0.0.1:7890";
  networking.proxy.noProxy = "127.0.0.1,localhost,siki.moe,yousiki.top,ybh1998.space,edu.cn";
  # Open firewall for clash.
  networking.firewall.allowedTCPPorts = [
    7890
    7891
  ];
  # Enable clash (mihomo, a.k.a clash-meta).
  services.mihomo = {
    enable = true;
    configFile = config.age.secrets.clash-config.path;
  };
  # Clash configuration from secrets.
  age.secrets.clash-config.file = "${inputs.self}/secrets/clash-config.yaml.age";
}
