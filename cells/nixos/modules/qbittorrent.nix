{
  inputs,
  cell,
}: {
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.services.qbittorrent;
  defaultUser = "qbittorrent";
  defaultGroup = defaultUser;

  webuiSubmodule = types.submodule {
    options = {
      address = mkOption {
        default = "127.0.0.1";
        type = types.str;
        description = "The IP address to which the webui will bind.";
      };
      port = mkOption {
        default = 8080;
        type = types.int;
        description = "The port to which the webui will bind.";
      };
    };
  };

  initializeAndRun = pkgs.writers.writeBash "initializeAndRun-qBittorrent-config" ''
    set -efu

    mkdir -p ${cfg.configDir}

    if [ ! -f ${cfg.configDir}/qBittorrent.conf ]; then
    cat >${cfg.configDir}/qBittorrent.conf <<EOL
    [LegalNotice]
    Accepted=true

    [Network]
    Cookies=@Invalid()

    [Preferences]
    Connection\PortRangeMin=62876
    Queueing\QueueingEnabled=false
    EOL
    fi

    ${cfg.package}/bin/qbittorrent-nox
  '';
in {
  options.services.qbittorrent = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Run qBittorrent as systemwide daemon
      '';
    };

    webui = mkOption {
      type = webuiSubmodule;
      default = {};
      description = "The IP and port to which the webui will bind.";
    };

    user = mkOption {
      type = types.str;
      default = "${defaultUser}";
      description = ''
        User account under which qBittorrent runs.
      '';
    };

    group = mkOption {
      type = types.str;
      default = "${defaultGroup}";
      description = ''
        Group under which qBittorrent runs.
      '';
    };

    dataDir = mkOption {
      type = types.path;
      default = "/var/lib/${defaultUser}";
      description = ''
        The directory where qBittorrent will create files.
      '';
    };

    configDir = mkOption {
      type = types.path;
      description = ''
        The path where the settings will exist.
      '';
      default = cfg.dataDir + "/.config/qBittorrent";
      defaultText = literalDocBook ''
        [LegalNotice]
        Accepted=true

        [Network]
        Cookies=@Invalid()

        [Preferences]
        Connection\PortRangeMin=62876
        Queueing\QueueingEnabled=false
        WebUI\Port=${cfg.webui.port}
      '';
    };

    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Open services.qBittorrent.port to the outside network.
      '';
    };

    package = mkOption {
      type = types.package;
      default = pkgs.qbittorrent-nox;
      defaultText = literalExpression "pkgs.qbittorrent-nox";
      description = ''
        The qbittorrent package to use.
      '';
    };
  };

  config = mkIf cfg.enable {
    networking.firewall = mkIf cfg.openFirewall {
      allowedTCPPorts = [cfg.webui.port];
    };

    environment.systemPackages = [cfg.package];

    systemd.packages = [cfg.package];

    users.users = mkIf (cfg.user == defaultUser) {
      ${defaultUser} = {
        group = cfg.group;
        home = cfg.dataDir;
        createHome = true;
        isSystemUser = true;
        description = "qBittorrent service user";
      };
    };

    users.groups = mkIf (cfg.group == defaultGroup) {${defaultGroup} = {gid = null;};};

    systemd.services.qbittorrent = {
      description = "qBittorrent Daemon";
      documentation = ["man:qbittorrent-nox(1)"];
      after = ["network-online.target" "nss-lookup.target"];
      wantedBy = ["multi-user.target"];
      wants = ["multi-user.target"];
      path = [pkgs.qbittorrent];
      serviceConfig = {
        Type = "exec";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = initializeAndRun;
      };
    };
  };
}
