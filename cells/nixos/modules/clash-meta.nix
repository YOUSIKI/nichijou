{
  inputs,
  cell,
}: {
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.services.clash-meta;
in
  with builtins // lib; {
    options = {
      services.clash-meta = {
        enable = mkEnableOption (mdDoc "clash-meta, another clash kernel.");

        package = mkOption {
          type = types.package;
          default = inputs.cells.common.packages.clash-meta;
          defaultText = literalExpression "pkgs.clash-meta";
          description = mdDoc "The package to use for clash-meta.";
        };

        configPath = mkOption {
          type = types.str;
          default = "/etc/clash-meta/config.yaml";
          defaultText = literalExpression "/etc/clash-meta/config.yaml";
          description = mdDoc "The path to the configuration file.";
        };

        port = mkOption {
          type = types.int;
          default = 7890;
          description = mdDoc "The port to open in the firewall.";
        };

        openFirewall = mkOption {
          type = types.bool;
          default = false;
          description = mdDoc "Open port in firewall";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = [cfg.package];

      networking.firewall = mkIf cfg.openFirewall {
        allowedTCPPorts = [cfg.port];
      };

      systemd = {
        packages = [cfg.package];
        services.clash-meta = {
          after = ["network.target" "NetworkManager.service" "systemd-networkd.service" "iwd.service" "systemd-resolved.service"];
          wantedBy = ["multi-user.target"];
          serviceConfig = {
            Type = "simple";
            LimitNPROC = 500;
            LimitNOFILE = 1000000;
            CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE CAP_SYS_TIME CAP_SYS_PTRACE CAP_DAC_READ_SEARCH";
            AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE CAP_SYS_TIME CAP_SYS_PTRACE CAP_DAC_READ_SEARCH";
            Restart = "always";
            ExecStartPre = "${pkgs.coreutils}/bin/sleep 1s";
            ExecStart = "${cfg.package}/bin/clash-meta -f ${cfg.configPath}";
            ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
          };
        };
      };
    };
  }
