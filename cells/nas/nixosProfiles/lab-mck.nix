{
  inputs,
  cell,
  config,
  ...
}: let
  mkCifs = cell.lib.mkCifsWithCredentials config.age.secrets.lab-mck-credentials.path;
in {
  age.secrets.lab-mck-credentials.file = "${inputs.self}/secrets/lab-mck-credentials.age";
  fileSystems = {
    "/mnt/lab-mck/home" = mkCifs "//nas-changping.ybh1998.space/home";
    "/mnt/lab-mck/share" = mkCifs "//nas-changping.ybh1998.space/share";
  };
}
