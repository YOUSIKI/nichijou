# Setup system proxy via clash.
{
  inputs,
  config,
  ...
}: {
  networking = {
    # Enable system proxy.
    proxy.default = "http://127.0.0.1:7890";
    proxy.noProxy = "127.0.0.1,localhost,siki.moe,yousiki.top,ybh1998.space,edu.cn";
    # Open firewall for clash.
    firewall.allowedTCPPorts = [
      7890
      7891
    ];
  };
  services = {
    # Enable clash (mihomo, a.k.a clash-meta).
    mihomo = {
      enable = true;
      configFile = config.age.secrets.clash-config.path;
    };
    # Enable cloudflare-warp.
    cloudflare-warp = {
      enable = true;
      openFirewall = true;
    };
  };
  # Clash configuration from secrets.
  age.secrets.clash-config.file = "${inputs.self}/secrets/clash-config.yaml.age";
}
