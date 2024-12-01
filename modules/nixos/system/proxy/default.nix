{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.system.proxy;
in {
  options.${namespace}.system.proxy = {
    enable = lib.mkEnableOption "Whether to enable system proxy";
  };

  config = lib.mkIf cfg.enable {
    networking = {
      # Enable system proxy.
      proxy.default = "http://127.0.0.1:7890";
      proxy.noProxy = "127.0.0.1,localhost,siki.moe,ybh1998.space";
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
        configFile = config.sops.secrets."clash.yaml".path;
      };
    };
  };
}
