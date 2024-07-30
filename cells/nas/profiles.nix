{
  inputs,
  cell,
}: let
  mkCifsWithCredentials = credentials: device: {
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
in {
  satoshi = {
    config,
    pkgs,
    lib,
    ...
  }: let
    mkCifs = mkCifsWithCredentials config.age.secrets.satoshi-credentials.path;
  in {
    age.secrets.satoshi-credentials.file = "${inputs.self}/secrets/satoshi-credentials.age";
    fileSystems."/mnt/satoshi/bangumi" = mkCifs "//satoshi.siki.moe/Bangumi";
    fileSystems."/mnt/satoshi/downloads" = mkCifs "//satoshi.siki.moe/Downloads";
    fileSystems."/mnt/satoshi/game" = mkCifs "//satoshi.siki.moe/Game";
    fileSystems."/mnt/satoshi/movie" = mkCifs "//satoshi.siki.moe/Movie";
    fileSystems."/mnt/satoshi/research" = mkCifs "//satoshi.siki.moe/Research";
  };

  lab-yyp = {
    config,
    pkgs,
    lib,
    ...
  }: let
    mkCifs = mkCifsWithCredentials config.age.secrets.lab-yyp-credentials.path;
  in {
    age.secrets.lab-yyp-credentials.file = "${inputs.self}/secrets/lab-yyp-credentials.age";
    fileSystems."/mnt/lab-yyp/home" = mkCifs "//nas.ybh1998.space/home";
    fileSystems."/mnt/lab-yyp/share" = mkCifs "//nas.ybh1998.space/share";
  };

  lab-mck = {
    config,
    pkgs,
    lib,
    ...
  }: let
    mkCifs = mkCifsWithCredentials config.age.secrets.lab-mck-credentials.path;
  in {
    age.secrets.lab-mck-credentials.file = "${inputs.self}/secrets/lab-mck-credentials.age";
    fileSystems."/mnt/lab-mck/home" = mkCifs "//nas-changping.ybh1998.space/home";
    fileSystems."/mnt/lab-mck/share" = mkCifs "//nas-changping.ybh1998.space/share";
  };
}
