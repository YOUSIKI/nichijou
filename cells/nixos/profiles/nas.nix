{
  inputs,
  cell,
}: {
  pkgs,
  config,
  ...
}: let
  credentials = config.age.secrets.nas-credentials.path;

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
      "credentials=${credentials}"
    ];
  };

  mkNfs = device: {
    device = device;
    fsType = "nfs";
    options = [
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
    ];
  };
in {
  age.secrets.nas-credentials.file = "${inputs.self}/secrets/nas-credentials.age";

  fileSystems."/mnt/nas-yyp-home" = mkCifs "//nas.ybh1998.space/home";
  fileSystems."/mnt/nas-yyp-share" = mkCifs "//nas.ybh1998.space/share";
  fileSystems."/mnt/nas-mck-home" = mkCifs "//nas-changping.ybh1998.space/home";
  fileSystems."/mnt/nas-mck-share" = mkCifs "//nas-changping.ybh1998.space/share";

  fileSystems."/mnt/nas-satoshi-bangumi" = mkNfs "satoshi.mck.cn.yousiki.top:/share/Bangumi";
  fileSystems."/mnt/nas-satoshi-downloads" = mkNfs "satoshi.mck.cn.yousiki.top:/share/Downloads";
  fileSystems."/mnt/nas-satoshi-movie" = mkNfs "satoshi.mck.cn.yousiki.top:/share/Movie";
  fileSystems."/mnt/nas-satoshi-research" = mkNfs "satoshi.mck.cn.yousiki.top:/share/Research";
}
