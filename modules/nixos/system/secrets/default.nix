{
  lib,
  pkgs,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.system.secrets;
in {
  options.${namespace}.system.secrets = {
    enable = lib.mkEnableOption "Whether to enable secrets management";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      age
      sops
      ssh-to-age
    ];

    sops = {
      defaultSopsFile = null;
      age = {
        sshKeyPaths = [
          "/etc/ssh/ssh_host_ed25519_key"
        ];
      };
      secrets = {
        "clash.yaml" = {
          sopsFile = lib.snowfall.fs.get-file "secrets/clash.yaml";
          key = "";
        };
        "nas-mck-credentials.env" = {
          sopsFile = lib.snowfall.fs.get-file "secrets/nas-mck-credentials.env";
          format = "dotenv";
          key = "";
        };
        "nas-yyp-credentials.env" = {
          sopsFile = lib.snowfall.fs.get-file "secrets/nas-yyp-credentials.env";
          format = "dotenv";
          key = "";
        };
        "nas-satoshi-credentials.env" = {
          sopsFile = lib.snowfall.fs.get-file "secrets/nas-satoshi-credentials.env";
          format = "dotenv";
          key = "";
        };
      };
    };
  };
}
