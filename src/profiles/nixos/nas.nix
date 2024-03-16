# Mount NAS servers on NixOS.
{globals, ...}: {
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.nas;
in {
  options.services.nas = {
    mountRoot = lib.mkOption {
      type = lib.types.str;
      default = "/mnt";
      description = "The root directory to mount NAS servers.";
    };
  };

  config = let
    mkCifs = device: {
      device = device;
      fsType = "cifs";
      options = [
        "noauto"
        "x-systemd.automount"
        "x-systemd.idle-timeout=60"
        "x-systemd.device-timeout=5s"
        "x-systemd.mount-timeout=5s"
        "noperm"
        "credentials=${config.sops.secrets.nas-credentials.path}"
      ];
    };
  in {
    fileSystems."${cfg.mountRoot}/nas-yyp-home" = mkCifs "//nas.ybh1998.space/home";
    fileSystems."${cfg.mountRoot}/nas-yyp-share" = mkCifs "//nas.ybh1998.space/share";
    fileSystems."${cfg.mountRoot}/nas-mck-home" = mkCifs "//nas-changping.ybh1998.space/home";
    fileSystems."${cfg.mountRoot}/nas-mck-share" = mkCifs "//nas-changping.ybh1998.space/share";
  };
}
